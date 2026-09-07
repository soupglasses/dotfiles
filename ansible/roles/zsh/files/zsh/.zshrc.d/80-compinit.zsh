# Stage 80: initialise the completion system exactly once.
#
# Files in stages 00-79 may configure completion or add directories to $fpath.
# They must all run before this file so compinit can discover their functions.
# Files in stages 81-98 may call compdef directly because this file defines it.
# Stage 99 remains reserved for syntax highlighting, which must load last.

autoload -Uz compinit

# Rebuild the dump at most once a day; loading a cached dump is much faster
# than re-scanning $fpath on every new shell.
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${_zcompdump:h}"

if [[ -n ${_zcompdump}(#qN.mh-24) ]]; then
  # Fresh enough, and -C skips the security check on $fpath.
  compinit -C -d "$_zcompdump"
else
  compinit -d "$_zcompdump"
  # Compile the dump so subsequent shells load bytecode.
  { zcompile -R -- "$_zcompdump" } &!
fi

unset _zcompdump

# bashcompinit lets the occasional bash-only completion script work too.
autoload -Uz bashcompinit && bashcompinit
