# ~/.zshrc
# vi: ft=zsh


# --- Basic Setup ---
unsetopt autocd beep extendedglob
bindkey -e
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export PYTHONDONTWRITEBYTECODE=1
export PYTHONBREAKPOINT=ipdb.set_trace
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WEECHAT_HOME="$HOME/.config/weechat"
export VAGRANT_DEFAULT_PROVIDER=virtualbox
export TERM=xterm-256color


# --- History ---
HISTFILE=~/.zsh_histfile
HISTSIZE=100_000
SAVEHIST=100_000
setopt share_history append_history inc_append_history extended_history
setopt hist_ignore_dups hist_reduce_blanks hist_verify 
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


# --- Prompt ---
## Prompt
PROMPT='%F{blue}%(4~|%-1~/…/%2~|%3~) %(?..%F{red}E%? )%f%# '
## Git integration
if [ -x "$(command -v git)" ]; then
    source ~/.zsh/git-status.zsh
    PROMPT='%F{blue}%(4~|%-1~/…/%2~|%3~)%f ${GITSTATUS_PROMPT}${GITSTATUS_PROMPT:+ }${VIRTUAL_ENV:+"%F{magenta}env "}%(?..%F{red}E%? )%f%# '
fi
## Setup Xterm title hooks
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}
function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}
if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi


# --- Custom Completions ---
## Kitty
if [ -x "$(command -v kitty)" ]; then
    kitty + complete setup zsh | source /dev/stdin
    alias ssh="TERM=xterm-256color ssh"
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
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=dark
    --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
    --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
    '
fi
## Userland bin
if ! [[ "$PATH" =~ "$HOME/.local/bin" ]]; then
    export PATH="$PATH:$HOME/.local/bin"
fi
## Rust bin
if ! [[ "$PATH" =~ "$HOME/.cargo/bin" ]]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi
## Dotnet bin
if ! [[ "$PATH" =~ "$HOME/.dotnet/tools" ]]; then
    export PATH="$PATH:/home/sofi/.dotnet/tools"
fi


# --- Colors ---
## File Colors
source $HOME/.dircolors
## Color tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## Cat/Bat Colors
if [ -x "$(command -v bat)" ]; then
    BAT_CONFIG_DIR="$(bat --config-dir)/themes"
    if [ ! -f "$BAT_CONFIG_DIR/Enki-Tokyo-Night.tmTheme" ]; then
        mkdir -p "$BAT_CONFIG_DIR"
        curl "https://raw.githubusercontent.com/enkia/enki-theme/master/scheme/Enki-Tokyo-Night.tmTheme" \
            -o "$BAT_CONFIG_DIR/Enki-Tokyo-Night.tmTheme"
        \bat cache --build
    fi
    unset BAT_CONFIG_DIR
    alias bat='bat --theme Enki-Tokyo-Night --style header,changes,numbers'
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
alias ssh-copy='rsync -ah --info=progress2'
alias rm='rm -i'
alias clear='clear -x'
## Shorthands
alias clip='xclip -sel clip'
alias c='clear'
alias q='exit'
alias py='python'
alias ipy='ipython'
alias lg='lazygit'
## Multi-dot expansion
## TODO: Figure out a programatic method to do this
##       that also doesnt break fasd.
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'


# --- Other Setup ---
## Make ls run after cd
function cd {
    builtin cd "$@" && ls
}
## Allow for autocd after making a new directory.
function mkdircd {
    mkdir -p -- "$1" &&
        cd -- "$1"
}
