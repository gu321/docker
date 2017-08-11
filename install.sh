#!/bin/bash

USER_PID=6188
groupadd -g $USER_PID dev
useradd -u $USER_PID -g $USER_PID -s /bin/bash -m dev
echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers ;

USER_PID=5188
groupadd -g $USER_PID ol
useradd -u $USER_PID -g $USER_PID -s /bin/bash -m ol
echo "ol ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers ;


if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
exit 0
fi

mkdir -p /var/log/supervisor/

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[include]
files = /etc/supervisor/conf.d/*.conf

[supervisord]
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
childlogdir=/var/log/supervisor
EOF

