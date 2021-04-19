# ~/.bash_aliases
# vi: ft=bash

# Quicker cd 
alias cd='cd '
alias ...='../..'
alias ....='../../..'
alias cd..='cd ..'
alias cd...='cd ...'
alias cd....='cd ....'

# Add colors
alias ls='ls --group --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color'
alias ipinfo='ip -brief -color address'
## Generic coloration of commands
if command -v grc &> /dev/null; then
    alias lsblk='grc lsblk'
    alias ping='grc ping'
    alias traceroute='grc traceroute'
    alias gcc='grc gcc'
    alias make='grc make'
    alias netstat='grc netstat'
    alias mount='grc mount'
    alias dig='grc dig'
    alias ifconfig='grc ifconfig'
    alias ps='grc ps'
    alias df='grc df'
    alias du='grc du'
    alias ipaddr='grc ipaddr'
    alias fdisk='grc fdisk'
    alias free='grc free'
    alias docker='grc docker'
    alias systemctl='grc systemctl'
    alias sysctl='grc sysctl'
    alias uptime='grc uptime'
fi

# Simpler command names
alias diskuse='dua interactive'
alias say='espeak-ng'
alias open='xdg-open'
alias svim='sudoedit'

# Quality of life
alias ping='ping -c 5'
alias cat='bat -pp --theme Dracula'
alias fastcopy='rsync -ah --info=progress2'
alias rm='rm -i'
alias clear='clear -x'
alias ssh='TERM=xterm-color ssh'

# Shorthands
alias c='clear'
alias l='ls'
alias cl='clear && ls'
alias q='exit'
alias ll='ls -lh'
alias lh='ll'
alias la='ls -a'
alias lha='ls -lha'

# Python
alias py='python'
alias ipy='ipython'
alias cpy='PYTHONDONTWRITEBYTECODE=0 python'
alias cipy='PYTHONDONTWRITEBYTECODE=0 ipython'
