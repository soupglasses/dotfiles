# Stage 99 is deliberately reserved for syntax highlighting.
# This must be sourced last: it wraps the ZLE widgets that earlier stages
# install, so widgets created afterwards would not be highlighted.

# TODO: Support linux better here.
_p="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -r "$_p" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="${_p:h}/highlighters"
  source "$_p"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi
unset _p
