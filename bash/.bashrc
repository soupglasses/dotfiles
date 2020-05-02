# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Import aliases
source $HOME/.bashrc_aliases

#Import PS1
source $HOME/.bashrc_ps1

# Set up history
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=10000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:history:c:clear:l:pwd"
shopt -s histappend
PROMPT_COMMAND='history -a'

# Make "cd" optional
shopt -s autocd

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
