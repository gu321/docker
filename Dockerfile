FROM ubuntu:17.10

ENV DEBIAN_FRONTEND noninteractive



RUN apt-get update ; \
apt-get upgrade -y;\
apt-get -y install supervisor cron locales mlocate tmux \
rsyslog tzdata libpng-dev dh-autoreconf ctags \
mercurial autoconf automake libtool nasm make pkg-config git \
openssh-server libpython-dev python-dev libpq-dev \
logrotate build-essential libsnappy-dev zlib1g-dev \
python3 sudo curl libpython3-dev netcat libffi-dev \
tree silversearcher-ag iputils-ping \
rsync nodejs npm vim xtail;\
locale-gen zh_CN.UTF-8; \
curl https://bootstrap.pypa.io/get-pip.py|python3 ;\
curl https://bootstrap.pypa.io/get-pip.py|python2 ;\
ln -s /usr/bin/nodejs /usr/bin/node;\
npm install -g n;n stable;\
npm install -g cnpm --registry=https://registry.npm.taobao.org; \
pip3 install virtualenv autopep8 trash-cli;\
cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime;\
pip2 install hg-git ;\
updatedb ;\
cnpm install -g pngquant-bin image-webpack-loader webpack webpack-dev-server gulp;


RUN git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim;\
vim +PluginInstall +qall;\
sed -i '/colorscheme/ i colorscheme solarized' /etc/vim/vimrc.local;\
mkdir -p /etc/vim/bundle/template/



RUN /tmp/install.sh;rm /tmp/install.sh

#COPY requirement.txt /tmp/requirement.txt
#RUN /home/ol/.py3env/bin/pip install -r /tmp/requirement.txt

USER ol

WORKDIR /home/ol



USER root
ENTRYPOINT ["/etc/rc.local"]
