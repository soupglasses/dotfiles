# Must be sourced last: it wraps the ZLE widgets that other plugins install,
# so anything loaded afterwards is not highlighted.

# TODO: Support linux better here.
_p="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -r "$_p" ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="${_p:h}/highlighters"
  source "$_p"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
fi
unset _p
