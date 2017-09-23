#!/bin/sh

# Kill process accessing nfs vols with fuser
mount|grep nfs|cut -d" " -f1|while read -r line; do fuser -k $line & done

# If fuser fails
mount|grep nfs|cut -d" " -f1|while read -r line; do lsof $line|awk '{print $2}'|while read -r pid; do kill -9 $pid & done; done

# Wait 10 sec
sleep 10

# Try forces unmount
mount|grep nfs|cut -d" " -f1|while read -r line; do umount -fv $line & done

# Wait for 10 sec
sleep 10

# Start lazy unmount on remaining mounts
mount|grep nfs|cut -d" " -f1|while read -r line; do umount -lfv $line & done

# Wait 5 sec
sleep 5

# Kill and unmount local volumes the same way
for line in a b c; do fuser -k $line & done
for line in a b c; do lsof $line|awk '{print $2}'|while read -r pid; do kill -9 $pid & done; done
sleep 5
for line in a b c; do umount -fv $line & done
sleep 5
for line in a b c; do umount -lfv $line & done
sleep 5

# Atlast shutdown host
shutdown -h now
