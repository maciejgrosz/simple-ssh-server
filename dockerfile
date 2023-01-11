FROM alpine:3.14
COPY entrypoint.sh entrypoint.sh

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk add --update --no-cache openssh
RUN apk add -U shadow 
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'exit' >> /etc/profile.d/locale.sh
RUN addgroup -S sshgroup && adduser -S -s /bin/sh sshuser -G sshgroup
RUN usermod -p '*' sshuser
RUN mkdir -p /home/sshuser/.ssh/
RUN echo "check out 'curl parrot.live'" > /etc/motd
RUN ssh-keygen -A

EXPOSE 22
ENTRYPOINT ["sh", "entrypoint.sh"]

