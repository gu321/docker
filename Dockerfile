FROM ubuntu:17.10

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update ; \
apt-get upgrade -y;\
apt-get -y install supervisor cron locales mlocate tmux \
htop rsyslog tzdata libpng-dev dh-autoreconf ctags dstat \
mercurial autoconf automake libtool nasm make pkg-config git \
openssh-server libpython-dev python-dev libpq-dev \
logrotate build-essential zlib1g-dev \
python3 sudo curl libpython3-dev netcat libffi-dev libevent-dev \
tree silversearcher-ag iputils-ping libgoogle-glog-dev \
libzip-dev libsnappy-dev libprotobuf-dev protobuf-compiler bzip2 \
gist rsync nodejs npm vim xtail whois p7zip-full postgresql-client;\
locale-gen zh_CN.UTF-8; \
curl https://bootstrap.pypa.io/get-pip.py|python3 ;\
curl https://bootstrap.pypa.io/get-pip.py|python2 ;\
ln -s /usr/bin/nodejs /usr/bin/node;\
npm install -g n;n stable;\
npm install -g cnpm --registry=https://registry.npm.taobao.org; \
pip3 install virtualenv autopep8 trash-cli ;\
cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime;\
pip2 install hg-git;\
updatedb ;\
cnpm install -g pngquant-bin image-webpack-loader webpack webpack-dev-server gulp pm2 coffee-script;\
find /usr/local/lib/node_modules/pm2/node_modules/ -type f -exec chmod 644 {} \;

#RUN curl -fsS https://dlang.org/install.sh | bash -s dmd

RUN git clone https://github.com/gu321/docker.git /tmp/docker --depth=1;\
rsync -av /tmp/docker/data/ /;

RUN git clone https://github.com/gu321/docker_home.git /home/docker --depth=1;\
rsync -av /home/docker/home/ /root;

RUN git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim --depth=1;\
vim +PluginInstall +qall;

#sed -i '/colorscheme/ i colorscheme molokai' /etc/vim/vimrc.local;

RUN bash /tmp/install.sh;rm /tmp/install.sh
RUN curl -fsS https://dlang.org/install.sh | bash -s dmd -p /opt/dlang

#COPY requirement.txt /tmp/requirement.txt
#RUN /home/ol/.py3env/bin/pip install -r /tmp/requirement.txt

USER ol

WORKDIR /home/ol



USER root
ENTRYPOINT ["/etc/rc.local"]
