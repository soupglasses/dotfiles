# ~/.bash_aliases

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
alias pep8='pycodestyle'
alias open='xdg-open'
alias archnews='informant'
alias optimize-png='find -iname "*.png" -print0 | xargs -0 -n 1 -P 7 optipng -preserve'
alias svim='sudoedit'

# Shortcuts to commonly edited files
alias edvim='vim ~/.vimrc'
alias edbash='vim ~/.bashrc'
alias edalias='vim ~/.bashrc_aliases'
alias edps1='vim ~/.bashrc_ps1'

# Quality of life
#alias yay='yay --pacman powerpill'
alias ping='ping -c 5'
alias cat='bat -pp'
alias cp='rsync -ah --info=progress2'
alias rm='rm -i'

# Shorthands
alias c='clear'
alias l='ls'
alias cl='clear && ls'
alias q='exit'
alias ll='ls -lh'
alias lh='ll'
alias la='ls -a'
alias lha='ls -lha'
