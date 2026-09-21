# Stage 85: register Docker completion after compinit has defined compdef.
# Generate it from the installed CLI on each shell start so completion stays in
# sync with Docker upgrades without maintaining a generated cache file.
if (( $+commands[docker] )); then
  eval "$(docker completion zsh)"
fi
