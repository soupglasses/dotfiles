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
export GPG_TTY=$(tty)

eval "$(fasd --init auto)"

# Imports
source $HOME/.dircolors
source $HOME/.bashrc_aliases
source $HOME/.bashrc_ps1

# Set up history
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=10000
export HISTFILESIZE=100000
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
PATH="$PATH:~/.scripts"
# NPM sourced from a non standard directory
PATH="~/.npm-global/bin:$PATH"

export PATH

# Make ls run after cd
function cd {
	builtin cd "$@" && ls
}
