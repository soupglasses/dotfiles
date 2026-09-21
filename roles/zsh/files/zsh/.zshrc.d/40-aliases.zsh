# BSD ls does not support --group-directories-first, so prefer eza.
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
elif ls --group-directories-first /dev/null >/dev/null 2>&1; then
  alias ls='ls --group-directories-first'
fi

if (( $+commands[pbcopy] )); then
  alias copy='pbcopy'
  alias paste='pbpaste'
elif (( $+commands[wl-copy] )); then
  alias copy='wl-copy'
  alias paste='wl-paste'
fi

if diff --color=auto /dev/null /dev/null >/dev/null 2>&1; then
  alias diff='diff --color=auto'
fi

alias grep='grep --color=auto'
alias tree='tree --dirsfirst'

# On macOS `open` is already the correct command.
if (( $+commands[xdg-open] )); then
  alias open='xdg-open'
fi

alias k=kubectl
alias py='python3'
alias ipy='ipython'
alias c='clear'
alias q='exit'

# ssh with a terminfo the remote end is likely to have.
alias ssh='TERM=xterm-256color ssh'

alias neofetch='fastfetch'

# Make a directory and step into it.
mkdircd() {
  mkdir -p -- "$1" && cd -- "$1"
}
