if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

if [ -f ~/.py3env/bin/activate ]; then
source ~/.py3env/bin/activate
fi

[ -z "$PS1" ] && return

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export EDITOR="/usr/bin/vim"
export LC_CTYPE=zh_CN.UTF-8 # 可以輸入UTF-8中文
export LC_MESSAGES=zh_CN.UTF-8 # 可以顯示UTF-8中文

HISTCONTROL=ignoreboth
HISTSIZE=200000
HISTFILESIZE=200000

export TERM='xterm-256color'
export PS1="\[\e[33;1m\]\u \w \[\e[0m\]"
export PATH=~/.py3env/bin:$PATH

if [ -f ~/.tmux_default ]; then
    ~/.tmux_default > /dev/null 2>&1 
fi

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
