#!/script/virtualenv/py3.6/bin/python

from subprocess import Popen, PIPE
import threading
from multiprocessing import Queue
import time
import json
from pprint import pprint
import sys
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
        p = Popen(["ssh","-q","-l","root","-i","/script/.ssh/id_rsa.jump","-o","StrictHostKeyChecking=no",host,cmd],
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

    hosts = [r["hostname"] for r in report]
    unix_hosts = [r["hostname"] for r in report if r["os"] == "unix"]

    if len(hosts) == 0: quit()

    pts, sts, pq, sq = [], [], Queue(), Queue()

    for host in hosts:
        pt = threading.Thread(target=ping_check, args=(host,pq,))
        pt.start()
        pts.append(pt)

        if host not in unix_hosts: continue

        st = threading.Thread(target=ssh_check, args=(host,sq,))
        st.start()
        sts.append(st)

    for t in pts: t.join()

    while not pq.empty():
        result = pq.get()
        opsautodb.update(table="dashboard_activity_monitor",
                        value={"ping_status": result[1]},
                        where={"title": title, "hostname": result[0]})
        # pprint(result)

    for t in sts: t.join()

    while not sq.empty():
        result = sq.get()
        data = {"ssh_status": result[1]}
        if result[1] == "accessible" and check != None:
            data[check] = result[2]
            if check == "post_check":
                pre_check = opsautodb.get(table="dashboard_activity_monitor",
                                        column="pre_check",
                                        where={"title": title, "hostname": result[0]})
                if pre_check == result[2]:
                    data["overall_status"] = 1
        opsautodb.update(table="dashboard_activity_monitor",
                        value=data,
                        where={"title": title, "hostname": result[0]})
        # pprint(result)


if __name__ == "__main__":

    # Exit if another session is open
    # if os.system("ps -ef|grep -v grep|grep "+__file__+"|") == 0: quit()

    title = " ".join(sys.argv[1:])

    # Ferform precheck
    update_all(title, "pre_check")

    # Start shutdown activity
    while True:
        records = opsautodb.select(table="dashboard_activity_monitor",
                                  where={"title": title, "ping_status": "up"})
        if len(records) == 0: break
        os.system("clear")
        print(len(records),"hosts still online")
        update_all(title)

    # Start poweron activity
    opsautodb.update(table="dashboard_activity_monitor",
                     value={"step": "poweron"},
                     where={"title": title})
    while True:
        records = opsautodb.select(table="dashboard_activity_monitor",
                                  where={"title": title, "overall_status": 0})
        if len(records) == 0: break
        os.system("clear")
        print(len(records),"hosts still having issue")
        update_all(title, "post_check")
