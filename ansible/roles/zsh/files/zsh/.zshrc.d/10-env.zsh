# Environment.

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
# Let Git discover manuals for user-installed subcommands such as git-profile.
export MANPATH="$HOME/.local/share/man:${MANPATH:-}"

# Keep $HOME tidy by preferring the XDG locations.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# TODO: Better go path for MacOS
export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"

export PYTHONDONTWRITEBYTECODE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

# gpg-agent needs this to know where to draw the pinentry prompt.
[[ -t 0 ]] && export GPG_TTY=$(tty)

# ~/.local/bin first, and only once, so re-sourcing this file is harmless.
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH
