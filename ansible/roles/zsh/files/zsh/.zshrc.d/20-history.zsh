# History.

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt share_history          # history is live across concurrent shells
setopt extended_history       # record timestamp and duration
setopt inc_append_history     # write as commands run, not just at exit
setopt hist_ignore_dups
setopt hist_ignore_space      # a leading space keeps a command out of history
setopt hist_reduce_blanks
setopt hist_verify             # expand a !! into the buffer for review first

# Up/down search history for what has already been typed.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
