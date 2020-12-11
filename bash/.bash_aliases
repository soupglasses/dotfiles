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
alias lsblk='grc lsblk'
alias ping='grc ping'

# Simpler command names
alias diskuse='dua interactive'
alias say='espeak-ng'
alias ipinfo='ip -brief -color address'
alias open='xdg-open'
alias optimize-pngs='find -iname "*.png" -print0 | xargs -0 -n 1 -P 7 optipng -preserve'
alias svim='sudoedit'

# Quality of life
alias ping='ping -c 5'
alias cat='bat -pp --theme Dracula'
alias fastcopy='rsync -ah --info=progress2'
alias rm='rm -i'
alias clear='clear -x'
alias cpy='PYTHONDONTWRITEBYTECODE=0 python'
alias cipy='PYTHONDONTWRITEBYTECODE=0 ipython'

# Shorthands
alias c='clear'
alias l='ls'
alias cl='clear && ls'
alias q='exit'
alias ll='ls -lh'
alias lh='ll'
alias la='ls -a'
alias lha='ls -lha'
alias py='python'
alias ipy='ipython'
