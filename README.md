# .dotfiles

Using [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles

## Install Stow Files
Install `stow` with your package manager.

Then clone the repo to your computer:
```bash
git clone https://gitlab.com/imsofi/dotfiles/ ~/.dotfiles
cd ~/.dotfiles/stow
```

Then you can use `stow --verbose --stow --target=$HOME $FOLDER` to install any of them.

## Removing Stow Files

Use `stow --delete --target=$HOME $FOLDER` to remove any installed stows.
