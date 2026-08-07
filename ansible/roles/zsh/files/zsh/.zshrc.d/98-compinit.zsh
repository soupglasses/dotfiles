# Initialise the completion system.
#
# This runs late on purpose: every snippet that adds to $fpath must have been
# sourced already, or its completions will be missing.

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
