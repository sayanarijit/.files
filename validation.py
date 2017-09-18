#!/script/virtualenv/py3.6/bin/python

from subprocess import Popen, PIPE
import threading
from queue import Queue
import time
import json
from pprint import pprint
import sys
import os
import argparse
from tqdm import tqdm, trange
from opsauto import *
# from dictmysql import DictMySQL, cursors


# opsautodb = DictMySQL(db='opsauto', host="localhost",
#                       user="root", passwd="abcd",
#                       cursorclass=cursors.DictCursor)
threadLimiter = threading.BoundedSemaphore(50) # Max threads


def ping_check(host, pq):
    threadLimiter.acquire()
    try:
        for i in range(1,2):
            p = Popen(["ping", "-c"+str(i), "-w"+str(i), host], stdout=PIPE, stderr=PIPE)
            p.communicate()
            rc = p.returncode
            if rc == 0:
                pq.put([host, "up"])
                return
        pq.put([host, "down"])
    finally:
        pass
        threadLimiter.release()

def ssh_check(host, sq):
    threadLimiter.acquire()
    cmds = ["mount|grep ^/dev/", "netstat -nr;route -n;ip route show", "ifconfig|grep 'inet '"]
    cmd = "/bin/sh -c '"+(" 2>/dev/null; echo [---x---];".join(cmds))+"; echo'"
    try:
        # p = Popen(["ssh","-q","-l","root","-i","/script/.ssh/id_rsa.jump","-o","StrictHostKeyChecking=no",host,cmd],
        p = Popen(["sudo","ssh","-q","-l","root","-o","StrictHostKeyChecking=no",host,cmd],
                  stdout=PIPE, stderr=PIPE)
        try:
            stdout, stderr = p.communicate(timeout=120)
            rc = p.returncode
            if rc == 0:
                checks = json.dumps(stdout.decode().split("[---x---]\n"))
                sq.put([host, "accessible", checks])
            else:
                sq.put([host, "inaccessible", None])
        except:
            sq.put([host, "inaccessible", None])
    finally:
        threadLimiter.release()


def update_all(title, check=None, hosts=[]):

    if len(hosts) == 0:
        where = {"title": title}
    else:
        where = {"title": title, "$IN": {"hostname": hosts}}

    report = opsautodb.select(table="dashboard_activity_monitor",
                              where=where)

    hosts, unix_hosts, ping_prechecks = set(), set(), {}

    for r in report:
        hosts.add(r["hostname"])
        if r["os"] == "unix": unix_hosts.add(r["hostname"])
        ping_prechecks[r["hostname"]] = r["ping_precheck"]

    if len(hosts) == 0: quit()

    pts, sts, pq, sq, = [], [], Queue(), Queue()
    up, down, accessible, inaccessible, validated = set(), set(), set(), set(), set()

    # Perform ping check
    for host in tqdm(hosts, desc='Starting ping check'):
        pt = threading.Thread(target=ping_check, args=(host,pq,))
        pt.start()
        pts.append(pt)
    for t in tqdm(pts, desc='Finishing ping check'): t.join()
    while not pq.empty():
        result = pq.get()
        if result[1] == "up":
            up.add(result[0])
            if check == "postcheck" and result[0] not in unix_hosts and ping_prechecks[result[0]] == result[1]:
                validated.add(result[0])
        else:
            down.add(result[0])
            if host in unix_hosts: inaccessible.add(result[0])

    # Update DB
    if len(up) > 0:
        value={"updated": time.strftime('%Y-%m-%d %H:%M:%S')}
        if check == "precheck":
            value["ping_precheck"] = "up"
        value["ping_status"] = "up"
        opsautodb.update(table="dashboard_activity_monitor",
                         value=value,
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(up)}})
    if len(down) > 0:
        value={"updated": time.strftime('%Y-%m-%d %H:%M:%S')}
        if check == "precheck":
            value["ping_precheck"] = "down"
            value["ssh_precheck"] = "inaccessible"
            value["ignored"] = 1
        value["ping_status"] = "down"
        value["ssh_status"] = "inaccessible"
        opsautodb.update(table="dashboard_activity_monitor",
                         value=value,
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(down)}})
    if len(inaccessible) > 0:
        value={"updated": time.strftime('%Y-%m-%d %H:%M:%S')}
        if check == "precheck":
            value["ssh_precheck"] = "inaccessible"
        value["ssh_status"] = "inaccessible"
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"ssh_status": "inaccessible",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(inaccessible)}})
    if len(validated) > 0:
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"overall_status": 1,
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(validated)}})


    if check == None: return

    up_unix_hosts, inaccessible, validated = (unix_hosts & up), set(), set()

    if len(up_unix_hosts) == 0: return

    if check == "postcheck":
        ssh_validations = {r["hostname"]: [r["ssh_precheck"], r["validation_precheck"]] for r in report}

    # Perform ssh check
    for host in tqdm(up_unix_hosts, desc='Starting ssh check'):
        st = threading.Thread(target=ssh_check, args=(host,sq,))
        st.start()
        sts.append(st)
    for t in tqdm(sts, desc='Finishing ssh check'): t.join()

    while not sq.empty():
        result = sq.get()
        if result[1] == "accessible":
            value={"updated": time.strftime('%Y-%m-%d %H:%M:%S')}
            if check == "precheck":
                value["ssh_precheck"] = "accessible"
                value["validation_precheck"] = result[2]
            else:
                value["ssh_status"] = "accessible"
                value["validation"] = result[2]
            if check == "postcheck" and ping_prechecks[result[0]] == "up":
                if ssh_validations[result[0]] == result[1:]:
                    value["overall_status"] = 1

            opsautodb.update(table="dashboard_activity_monitor",
                             value=value,
                             where={"title": title, "ignored": 0,
                                    "hostname": result[0]})
        else:
            inaccessible.add(result[0])

    # Update DB
    if len(inaccessible) > 0:
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"ssh_status": "inaccessible",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(inaccessible)}})

if __name__ == "__main__":

    ap = argparse.ArgumentParser(prog=__file__, description=None)

    ap.add_argument('-title', dest="title", nargs='*', default=[],
                    help='Title for the activity')
    ap.add_argument('-hosts', dest="hosts", nargs='*', default=[],
                    help='Hostnames to scan (optional)')
    ap.add_argument('--postcheck', dest="postcheck", action='store_true', default=False,
                    help='Perform scan for postcheck activity rather than only ping check (if hosts are mentioned)')
    ap.add_argument('--version', action='version', version='%(prog)s 1.0')

    args = ap.parse_args()

    if len(args.title) == 0:
        ap.print_help()
        quit(1)

    title = " ".join(args.title)

    if len(args.hosts) > 0:
        # Perform scan only on specified hosts
        check = "postcheck" if args.postcheck else None
        hosts = args.hosts
        update_all(title, check, hosts)
        quit(0)


    # Else perform scan on all hosts and enter monitoring mode

    if not args.postcheck:
        # Perform precheck
        update_all(title, "precheck")

        # Start shutdown activity
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"step": "shutdown",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title})
        while True:
            records = opsautodb.select(table="dashboard_activity_monitor",
                                      where={"title": title, "ping_status": "up",
                                             "ignored": 0})
            if len(records) == 0: break
            os.system("clear")
            print(len(records),"hosts still online")
            update_all(title)
            time.sleep(2)

    else:
        # Start poweron activity
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"step": "poweron",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title})
        while True:
            records = opsautodb.select(table="dashboard_activity_monitor",
                                      where={"title": title, "overall_status": 0,
                                             "ignored": 0})
            if len(records) == 0: break
            os.system("clear")
            print(len(records),"hosts still having issue")
            update_all(title, "postcheck")
            time.sleep(2)

        opsautodb.update(table="dashboard_activity_monitor",
                         value={"step": "complete",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title})
    print("Activity complete...")
