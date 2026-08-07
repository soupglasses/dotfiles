# zsh-autosuggestions, installed by the zsh role from Homebrew.

_p="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -r "$_p" ]]; then
  source "$_p"
  # Suggest from history only; the completion strategy is slow on big repos.
  ZSH_AUTOSUGGEST_STRATEGY=(history)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  bindkey '^ ' autosuggest-accept   # ctrl-space accepts the suggestion
fi
unset _p
