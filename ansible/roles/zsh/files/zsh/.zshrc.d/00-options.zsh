# Shell options.

setopt extended_glob        # #, ~ and ^ as pattern operators
setopt glob_dots            # let globs match dotfiles without an explicit .
setopt no_beep
setopt interactive_comments # allow # comments in an interactive shell

unsetopt auto_cd            # a bare directory name is a typo, not a cd
unsetopt flow_control       # free up ctrl-s / ctrl-q
unsetopt nomatch            # leave an unmatched glob alone rather than erroring

# Directory stack: cd -<tab> walks where you have been.
setopt auto_pushd pushd_ignore_dups pushd_silent
DIRSTACKSIZE=20

# Emacs keybindings, independent of $EDITOR.
bindkey -e
