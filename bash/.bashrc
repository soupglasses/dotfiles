# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Enable programmable completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Source fzf bash completion
[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash

# Custom colors
COLOR_PRIMARY="\033[38;5;49m"
COLOR_SECONDARY="\033[38;5;99m"
COLOR_TERTIARY="\033[38;5;220m"
COLOR_GREY="\033[38;5;249m"
COLOR_RESET="\033[0m"

# Exports
export EDITOR=vim
export GPG_TTY=$(tty)

# Imports
source $HOME/.dircolors
source $HOME/.bash_aliases
source $HOME/.bash_ps1

# Set up history
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTIGNORE=""
shopt -s histappend
PROMPT_COMMAND='history -a'

# Fasd config
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias v='f -e $EDITOR'
alias o='a -e xdg-open'
_fasd_bash_hook_cmd_complete v o

# Fzf config
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg -L --files'
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

# Disable CTRL-S
stty -ixon

# Ability to run custom scripts
#if [ -d "$HOME/.scripts" ]; then
#    PATH="$PATH:$HOME/.scripts"
#fi

# NPM sourced from a non standard directory
if [ -d "/home/sofi/.npm-global/bin" ]; then
    export PATH="/home/sofi/.npm-global/bin:$PATH"
fi

# Colored man pages
function man {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[00;47;30m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;33m' \
    command man "$@"
}

# Make ls run after cd
function cd {
    builtin cd "$@" && ls --group-directories-first
}
