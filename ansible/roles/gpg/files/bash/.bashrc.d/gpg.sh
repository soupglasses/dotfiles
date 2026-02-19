export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

alias gpg-relearn-card='gpg-connect-agent "scd serialno" "learn --force" /bye'
