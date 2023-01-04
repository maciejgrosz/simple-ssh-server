FROM alpine:3.14

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk add --update --no-cache openssh
RUN apk add -U shadow 
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'exit' >> /etc/profile.d/locale.sh
RUN addgroup -S sshgroup && adduser -S -s /bin/sh sshuser -G sshgroup
RUN usermod -p '*' sshuser
RUN mkdir -p /home/sshuser/.ssh/
RUN echo "check out 'curl parrot.live'" > /etc/motd
WORKDIR /home/sshuser/.ssh
RUN mkfifo key && ((cat key ; rm key)&) && (echo y | ssh-keygen -t rsa -C sshuser -N "" -f key > /dev/null)
RUN mv key.pub authorized_keys
RUN ssh-keygen -A

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]

