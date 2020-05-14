# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Custom colors
COLOR_PRIMARY="\033[38;5;49m"
COLOR_SECONDARY="\033[38;5;99m"
COLOR_TERTIARY="\033[38;5;220m"
COLOR_GREY="\033[38;5;249m"
COLOR_RESET="\033[0m"

# Exports
export EDITOR="vim"

# Imports
source $HOME/.dircolors
source $HOME/.bashrc_aliases
source $HOME/.bashrc_ps1
source $HOME/.bashrc_bookmarks

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

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Remove need to use ./ on executable files
PATH="$PATH:."

# Ability to run custom scripts
PATH="~/.scripts:$PATH"

# NPM programs sourced from a non standard directory
PATH="~/.npm-global/bin:$PATH"

export PATH

# Thefuck alias
eval "$(thefuck --alias)"

# Make ls run after cd
function cd {
	builtin cd "$@" && ls
}
