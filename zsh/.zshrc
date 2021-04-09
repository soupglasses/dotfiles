# ~/.zshrc
# vi: ft=zsh

# --- Basic Setup ---
unsetopt autocd beep extendedglob
bindkey -e
## Prompt
PROMPT='%F{blue}%(4~|%-1~/…/%2~|%3~)%f %# '
RPROMPT='%(?..%F{red}%?)'
## Defaults
EDITOR=nvim


# --- History ---
HISTFILE=~/.zsh_histfile
HISTSIZE=100000
SAVEHIST=100000
setopt share_history append_history inc_append_history extended_history
setopt hist_ignore_dups hist_reduce_blanks 
## Arrow bindings
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search 


# --- Zsh Completions ---
zstyle :compinstall filename '/home/sofi/.zshrc'
## Case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
## Compinstall
autoload -Uz compinit
compinit


# --- Custom Completions ---
## Kitty
if [ -x "$(command -v kitty)" ]; then
    kitty + complete setup zsh | source /dev/stdin
fi
## Fasd
if [ -x "$(command -v fasd)" ]; then
    fasd_cache="$HOME/.fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
    alias v='f -e $EDITOR'
    alias o='a -e xdg-open'
fi
## Fzf
if [ -x "$(command -v fzf)" ]; then
    source /usr/share/fzf/shell/key-bindings.zsh
fi


# --- Colors ---
## GRC Coloration
if [[ -r /etc/grc.zsh ]]; then
    source /etc/grc.zsh
    unalias ls
fi
## Cat/Bat Colors
if [ -x "$(command -v bat)" ]; then
    alias bat='bat --theme Dracula'
    alias cat='bat -pp'
fi
## Generic Commands
alias ls='ls --group --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color'


# --- Aliases ---
## Simpler Use
alias open='xdg-open'
alias svim='sudoedit'
## QoL
alias ipinfo='ip -breif -color address'
alias ping='ping -c 5'
alias fastcopy='rsync -ah --info=progress2'
alias rm='rm -i'
alias clear='clear -x'
alias ssh='TERM=xterm-256color ssh'
## Shorthands
alias c='clear'
alias q='exit'
alias py='python'
alias ipy='ipython'


# --- Other Setup ---
## Make ls run after cd
function cd {
    builtin cd "$@" && ls
}
