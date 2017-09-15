from subprocess import Popen, PIPE
import threading
import queue
import time
import json
from pprint import pprint

hosts = ["pc","localhost","127.0.0.1", "yooooooooo", "freebie", "uboo14", "centoo6"]

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
    cmd = "/bin/sh -c '"+(" 2>/dev/null; echo [---x---];".join(cmds))+"'"
    try:
        p = Popen(["sudo","ssh", "-q", "-o", "StrictHostKeyChecking=no", host, cmd], stdout=PIPE, stderr=PIPE)
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

pts, sts, pq, sq = [], [], queue.Queue(), queue.Queue()
threadLimiter = threading.BoundedSemaphore(50)

for host in hosts:
    pt = threading.Thread(target=ping_check, args=(host,pq,))
    pt.start()
    pts.append(pt)

    st = threading.Thread(target=ssh_check, args=(host,sq,))
    st.start()
    sts.append(st)

for t in pts: t.join()

while not pq.empty():
    result = pq.get()
    pprint(result)

for t in sts: t.join()

while not sq.empty():
    result = sq.get()
    pprint(result)
