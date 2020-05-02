# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Import aliases
source $HOME/.bashrc_aliases

# Personal PS1
COLOR_RED="\033[38;5;160m"
COLOR_YELLOW="\033[38;5;220m"
COLOR_GREEN="\033[38;5;49m"
COLOR_RESET="\033[0m"
COLOR_GREY="\033[38;5;250m"

PROMPT_DIRTRIM=2

if [[ "$TERM" =~ 256color ]]; then
	PS1="\[$COLOR_GREEN\]\w \[$COLOR_GREY\]\$\[$COLOR_RESET\] "
	export GREP_COLOR="38;5;49"
else
	export PS1="\[\033[01;96m\]\w\[\033[0m\] \$ "
	export GREP_COLOR="01;96"
fi

# Set up history
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=10000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:history:c:clear:l:pwd"
shopt -s histappend
PROMPT_COMMAND='history -a'

# Make "cd" optional
# shopt -s autocd

# Remove need to use ./ on executable files
export PATH="$PATH:."

# Thefuck alias
eval "$(thefuck --alias)"

# NPM programs sourced from a non standard directory
export PATH="~/.npm-global/bin:$PATH"

# Make ls run after cd
function cd {
	builtin cd "$@" && ls
}

