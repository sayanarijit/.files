#!/script/virtualenv/py3.6/bin/python

from subprocess import Popen, PIPE
import threading
from queue import Queue
import time
import json
from pprint import pprint
import sys
import os
from tqdm import tqdm, trange
from opsauto import *

threadLimiter = threading.BoundedSemaphore(50) # Max threads


def ping_check(host, pq):
    threadLimiter.acquire()
    try:
        for i in range(1,5):
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
                sq.put([host, "inaccessible"])
        except:
            sq.put([host, "inaccessible"])
    finally:
        threadLimiter.release()


def update_all(title, check=None):
    report = opsautodb.select(table="dashboard_activity_monitor",
                              where={"title": title})

    hosts, unix_hosts = set(), set()

    for r in report:
        hosts.add(r["hostname"])
        if r["os"] == "unix": unix_hosts.add(r["hostname"])

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
            if check == "postcheck" and result[0] not in unix_hosts:
                validated.add(result[0])
        else:
            down.add(result[0])
            if host in unix_hosts: inaccessible.add(result[0])

    # Update DB
    if len(up) > 0:
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"ping_status": "up",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(up)}})
    if len(down) > 0:
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"ping_status": "down",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title, "ignored": 0,
                                "$IN": {"hostname": list(down)}})
    if len(inaccessible) > 0:
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
        prechecks = {r["hostname"]: r["precheck"] for r in report}

    # Perform ssh check
    for host in tqdm(up_unix_hosts, desc='Starting ssh check'):
        st = threading.Thread(target=ssh_check, args=(host,sq,))
        st.start()
        sts.append(st)
    for t in tqdm(sts, desc='Finishing ssh check'): t.join()
    while not sq.empty():
        result = sq.get()
        if result[1] == "accessible":
            value = {"ssh_status": "accessible","updated": time.strftime('%Y-%m-%d %H:%M:%S')}
            if check != None: value[check] = result[2]
            opsautodb.update(table="dashboard_activity_monitor",
                             value=value,
                             where={"title": title, "ignored": 0,
                                    "hostname": result[0]})
            if check == "postcheck" and prechecks[result[0]] == result[2]:
                validated.add(result[0])
        else:
            inaccessible.add(result[0])

    # Update DB
    if len(inaccessible) > 0:
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

if __name__ == "__main__":

    title = " ".join(sys.argv[1:])

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

    # Start poweron activity
    opsautodb.update(table="dashboard_activity_monitor",
                     value={"step": "poweron",
                            "ignored": 0,
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
    print("Activity complete...")
