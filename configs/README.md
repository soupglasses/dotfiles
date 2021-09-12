# configs/ (aka. Dotfiles)

My configuration files use [GNU Stow](https://www.gnu.org/software/stow/) for
management. You will need to install `stow` first with your preferred package
manager.

## Downloading and Applying

Clone the repo to your computer, I prefer it to be located in `~/.dotfiles`.
Which can be done with the following commands:

```bash
git clone https://gitlab.com/imsofi/dotfiles ~/.dotfiles && \
cd ~/.dotfiles/configs
```

You can now use `stow --verbose --stow --target=$HOME FOLDER_NAME` to
manually apply any of the available folders.

I use the `install.sh` and `remove.sh` that will do this automatically with
the folders defined in the `enabled` file. This file holds my currently used
configurations for my computer.

NOTE: Not every folder in here is used anymore and kept around for archival
purpouses, I reccomend to see the `enabled` for which ones are currently used
and up to date.

### Removing

Use `stow --delete --target=$HOME $FOLDER` to remove any installed stows.

If you used `install.sh`, you can just use `remove.sh` to do the same
automatically.

