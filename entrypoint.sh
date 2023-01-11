#!/bin/sh

mkfifo key && ((cat key ; rm key)&) && (echo y | ssh-keygen -t rsa -C sshuser -N "" -f key > /dev/null)
mv key.pub /home/sshuser/.ssh/authorized_keys
exec /usr/sbin/sshd -D -e