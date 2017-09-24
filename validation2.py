#!/script/virtualenv/py3.6/bin/python

from subprocess import Popen, PIPE
import threading
from queue import Queue
import time
import json
from pprint import pprint
import sys
import os
import re
from shlex import quote
import argparse
from tqdm import tqdm, trange
from opsauto import *
# from dictmysql import DictMySQL, cursors


# opsautodb = DictMySQL(db='opsauto', host="localhost",
#                       user="root", passwd="",
#                       cursorclass=cursors.DictCursor)
threadLimiter = threading.BoundedSemaphore(50) # Max threads


def ping_check(host, pq):
    threadLimiter.acquire()
    try:
        p = Popen(["ping", "-c2", "-w2", host], stdout=PIPE, stderr=PIPE)
        p.communicate(timeout=10)
        rc = p.returncode
        if rc == 0:
            pq.put([host, "up"])
        else:
            pq.put([host, "down"])
    except:
        pq.put([host, "down"])
    finally:
        threadLimiter.release()

def ssh_check(host, check, title, sq):
    threadLimiter.acquire()
    filepath = "/activity-monitor/"+re.sub("[^a-zA-Z0-9-]","_",title)+"-"
    if check == "precheck":
        cmds = ["mkdir /activity-monitor;mount|grep ^/dev/", "netstat -nr;route -n;ip route show",
                "ifconfig -a|grep \"inet \"","cat /etc/fstab|grep -v ^#","ypwhich",
                "mount|grep ^/dev/|grep -v /boot|grep -v /proc|grep -v /opt|grep -v /var|grep -v /tmp|grep -v /var|grep -v tmpfs|cut -d\" \" -f3|while read -r line; do touch $line/rw_test && echo $line; done > "+filepath+"rw_test_pre; cat "+filepath+"rw_test_pre",
                "mount|grep nfs|grep /vol|grep -v /homes|tail -1|cut -d\" \" -f3 > "+filepath+"nfs_vol_pre;cat "+filepath+"nfs_vol_pre",
                "mount|grep nfs|grep /homes|tail -1|cut -d\" \" -f3 > "+filepath+"nfs_home_pre; cat "+filepath+"nfs_home_pre"]
    else:
        cmds = ["mount|grep ^/dev/", "netstat -nr;route -n;ip route show",
                "ifconfig|grep \"inet \"","cat /etc/fstab|grep -v ^#","ypwhich",
                "cat "+filepath+"rw_test_pre|while read -r line; do touch $line/rw_test && echo $line; done > "+filepath+"rw_test_post; cat "+filepath+"rw_test_post",
                "ls -d $(cat "+filepath+"nfs_vol_pre) > "+filepath+"nfs_vol_post; cat "+filepath+"nfs_vol_post",
                "ls -d $(cat "+filepath+"nfs_home_pre) > "+filepath+"nfs_home_post; cat "+filepath+"nfs_home_post"]

    cmd = "/bin/sh -c "+quote((" 2>/dev/null; echo [---x---];".join(cmds))+"; echo")
    with open("testcmd","w") as f: f.write(cmd)
    # quit()
    try:
        p = Popen(["ssh","-q","-l","root","-i","/script/.ssh/id_rsa.jump","-o","StrictHostKeyChecking=no",host,cmd],
        # p = Popen(["sudo","ssh","-q","-l","root","-o","StrictHostKeyChecking=no",host,cmd],
                  stdout=PIPE, stderr=PIPE)
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

def validate(prechecks, postchecks):
    if not prechecks or len(prechecks) == 0: return []
    if not postchecks or len(postchecks) == 0: postchecks = json.dumps([[] for i in range(len(prechecks))])

    prechecks, postchecks = json.loads(prechecks), json.loads(postchecks)
    checks = ["Local mounts","IP routes","IP address","fstab","NIS server",
              "Local rw test","NFS mount check","Home directory check"]
    failed = []
    for i in range(len(prechecks)):
        if i == len(checks): break
        if i == len(postchecks): postchecks.append([])
        set1 = set([" ".join(x.strip().split()[:3]) for x in prechecks[i].splitlines()])
        set2 = set([" ".join(x.strip().split()[:3]) for x in postchecks[i].splitlines()])
        if len(set1 - set2) > 0:
            failed.append([checks[i], prechecks[i], postchecks[i]])
    return failed

def update_all(title, check=None, hosts=[]):

    if len(hosts) == 0:
        where = {"title": title, "ignored": 0}
    else:
        where = {"title": title, "ignored": 0, "$IN": {"hostname": hosts}}

    report = opsautodb.select(table="dashboard_activity_monitor",
                              where=where)

    hosts, unix_hosts, ping_prechecks, ssh_validations = set(), set(), {}, {}

    for r in report:
        hosts.add(r["hostname"])
        if r["os"] in ["unix","ccpvm"]: unix_hosts.add(r["hostname"])
        ping_prechecks[r["hostname"]] = r["ping_precheck"]
        ssh_validations[r["hostname"]] = [r["ssh_precheck"], r["validation_precheck"]]

    if len(hosts) == 0: quit()

    pts, sts, pq, sq, = [], [], Queue(), Queue()
    up, down, accessible = set(), set(), set()
    inaccessible, validated, issue =  set(), set(), set()

    # Perform ping check
    for host in tqdm(hosts, desc='Starting ping check'):
        pt = threading.Thread(target=ping_check, args=(host,pq,))
        pt.start()
        pts.append(pt)
    for t in tqdm(pts, desc='Finishing ping check'): t.join()

    while not pq.empty():
        host, status = pq.get()
        value = {"updated": time.strftime('%Y-%m-%d %H:%M:%S')}
        if check == "precheck":
            value["ping_precheck"] = value["ping_status"] = status
            if status == "down": value["ignored"] = 1
        elif check == None:
            value["ping_status"] = status
        elif check == "postcheck":
            value["ping_status"] = status
            if ping_prechecks[host] == status and host not in unix_hosts:
                value["overall_status"] = 1
            elif host not in unix_hosts:
                value["overall_status"] = 0
        if status == "up":
            up.add(host)
        elif host in unix_hosts:
            value["ssh_status"] = "inaccessible"
        opsautodb.update(table="dashboard_activity_monitor",
                         value=value,
                         where={"title": title, "ignored": 0,
                                "hostname": host})


    if check == None: return

    up_unix_hosts = (unix_hosts & up)

    if len(up_unix_hosts) == 0: return

    # Perform ssh check
    for host in tqdm(up_unix_hosts, desc='Starting ssh check'):
        st = threading.Thread(target=ssh_check, args=(host,check,title,sq,))
        st.start()
        sts.append(st)
    for t in tqdm(sts, desc='Finishing ssh check'): t.join()

    while not sq.empty():
        host, status, validation = sq.get()
        value={"updated": time.strftime('%Y-%m-%d %H:%M:%S')}
        if check == "precheck":
            value["ssh_precheck"] = value["ssh_status"] = status
            value["validation_precheck"] = validation
        else:
            value["ssh_status"] = status

            if status != ssh_validations[host][0]:
                value["overall_status"] = 0
            else:
                failed = validate(ssh_validations[host][1], validation)
                if len(failed) == 0:
                    value["validation"] = None
                    value["overall_status"] = 1
                else:
                    value["validation"] = json.dumps(failed)
                    value["overall_status"] = 0
                    print(host,"\n===========\n".join(["\n--------\n".join(f) for f in failed]),sep="\n______\n")

        opsautodb.update(table="dashboard_activity_monitor",
                         value=value,
                         where={"title": title, "ignored": 0,
                                "hostname": host})


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
            try:
                records = opsautodb.select(table="dashboard_activity_monitor",
                                          where={"title": title, "ping_status": "up",
                                                 "ignored": 0})
                if len(records) == 0: break
                os.system("clear")
                print(len(records),"hosts still online")
                update_all(title)
            except Exception as e:
                print(e)
            time.sleep(2)

    else:
        # Start poweron activity
        opsautodb.update(table="dashboard_activity_monitor",
                         value={"step": "poweron",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title})
        while True:
            try:
                records = opsautodb.select(table="dashboard_activity_monitor",
                                          where={"title": title, "overall_status": 0,
                                                 "ignored": 0})
                if len(records) == 0: break
                os.system("clear")
                print(len(records),"hosts still having issue")
                update_all(title, "postcheck")
                time.sleep(2)
            except Exception as e:
                print(e)
            time.sleep(2)

        opsautodb.update(table="dashboard_activity_monitor",
                         value={"step": "complete",
                                "updated": time.strftime('%Y-%m-%d %H:%M:%S')},
                         where={"title": title})
    print("Activity complete...")
