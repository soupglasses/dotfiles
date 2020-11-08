# ~/.bashrc

# Global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# If not running interactively, don't do anything more
[[ $- != *i* ]] && return

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion
## Kitty completion
[ -x "$(command -v kitty)" ] && . <(kitty + complete setup bash)
## Fzf bash completion
[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash

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
# 'history -a' handled in .bash_ps1

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

# Disable annoying CTRL-S
stty -ixon

# Ability to run custom scripts
if [ -d "$HOME/.scripts" ]; then
    PATH="$PATH:$HOME/.scripts"
fi

# NPM sourced from a non standard directory
if [ -d "/home/sofi/.npm-global/bin" ]; then
    export PATH="$PATH:$HOME/.npm-global/bin"
fi


# Title
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/\~}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*|_fasd*|cd*|ls*|c|clear)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac


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
