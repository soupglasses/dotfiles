# dotfiles

My own personal repo containing my dotfiles plus extras.


## Table of contents

- [Editor - Neovim](docs/nvim.md)
- [Shell - Zsh](docs/zsh.md)
- [Terminal - Kitty](docs/kitty.md)


## Help, i cant see code in my editor!

Some files under this repo are organized with [Vim Folds](https://vim.fandom.com/wiki/Folding). Vim folds allows code to be grouped into logical sections, like a `Font` fold, or a `Keyboard Shortcuts` fold. These folds will give an overview by each folds name, letting you find important sections of a file quickly.

If you have not used folds in vim before, its `zR` to open all folds, `zM` to close all folds. There is also `za` to toggle individual levels of folds.


## configs/

This folder holds my configuration files, (also called dotfiles) together with
mangement scripts to help install/remove them.

My configuration files use [GNU Stow](https://www.gnu.org/software/stow/) for
management. You will need to install `stow` first with your preferred package
manager.

### Installation

Clone the repo to your computer, I prefer it to be located in `~/.dotfiles`.
Which can be done with the following commands:

```bash
git clone git@git.sr.ht:~sofi/dotfiles ~/.dotfiles && \
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

### Removal

Use `stow --delete --target=$HOME $FOLDER` to remove any installed stows.

If you used `install.sh`, you can just use `remove.sh` to do the same
automatically.


## keyboard/

This is my custom keyboard remapping solution. It allows me to rebind keys like
Capslock to become both ESC and CTRL depending on if i hold the key down or
just tap it.

Usually this is done keyboard side with software, for example with
[QMK](https://qmk.fm/). But my keyboard is an old IBM Thinkpad travel keyboard,
which does not have such niceties. So I am doing it trough software with
[dual-function-keys](https://gitlab.com/interception/linux/plugins/dual-function-keys)
and [interception-tools](https://gitlab.com/interception/linux/tools).
This has the added benefit of working with any keyboard, including the built in
one on my laptop.

Notably, I'm changing Capslock to be Left Control and Escape. Which is extremely
helpful for vim, as it commonly uses ESC for going out of its many modes.

### Requirements

* [dual-function-keys](https://gitlab.com/interception/linux/plugins/dual-function-keys/)
* [interception-tools](https://gitlab.com/interception/linux/tools)
* [A running udevmon daemon](https://gitlab.com/interception/linux/tools#execution)

### Installation

Either follow each README in the requirements above, or if you have Fedora you can run
my `install-fedora.sh` script which will install the needed dependencies, enable them,
and run `apply.sh` to install configurations from `keyboard/configs/`.

### Configuration

Per keyboard configuration is held in `keyboard/configs/`. See
[dual-function-keys examples](https://gitlab.com/interception/linux/plugins/dual-function-keys/-/blob/master/doc/examples.md)
for how to create your own.

You can also follow the
[dual-function-keys README](https://gitlab.com/interception/linux/plugins/dual-function-keys/-/blob/master/README.md)
for how to find out your keyboard id/name if you want to make your configurations
be per keyboard.

After configuring to your keyboard, you can run `apply.sh` as root to install it.


## setup/

My Ansible setup scripts to configure my computer. Mainly only for my own use currently.

Only supports Fedora. Run: `./run.sh` to install.
