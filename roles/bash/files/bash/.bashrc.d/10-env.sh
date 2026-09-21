export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
export TERM=xterm-256color

# User-installed commands and helpers take precedence over system packages.
case ":$PATH:" in
	*:"$HOME/.local/bin":*) ;;
	*) export PATH="$HOME/.local/bin:$PATH" ;;
esac
