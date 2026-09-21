# Stage 30: configure completion and register completion search paths.
#
# Do not call compinit here. Every $fpath producer belongs in stages 30-79;
# 80-compinit.zsh initializes the system once after all of them have loaded.
# Tools whose generated init code calls compdef belong in stages 81-98 instead.

# Homebrew's completions are not on $fpath by default.
if (( $+commands[brew] )); then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

# Case-insensitive, then partial-word, then substring matching.
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}no matches%f'

# Colour completion listings like ls does.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Cache the expensive completers.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Do not suggest what is already on the command line.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other

setopt complete_in_word       # complete from the cursor, not the end of the word
setopt always_to_end
unsetopt menu_complete        # show the menu rather than inserting a guess
setopt auto_menu
