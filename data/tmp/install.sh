#!/bin/bash

function INIT_USER {
groupadd -g $2 $1
useradd -u $2 -g $2 -s /bin/bash -m $1
echo -e "$1 ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers ;
rsync -av /tmp/docker_home/home/  /home/$1/
chown -R $1:$1 /home/$1/*
}

INIT_USER ol 5188
INIT_USER dev 6188

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


cd /tmp
git clone --recursive https://github.com/Qihoo360/pika --depth=1
cd pika
git submodule update --recursive --init --depth=1
make __REL=1
make install
rm -rf /tmp/pika
