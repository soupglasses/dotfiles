# dotfiles

My own personal repo containing my dotfiles plus extras.


## Dotfiles

Configuration files use [GNU Stow](https://www.gnu.org/software/stow/) for
management. You will need to install `stow` first with your package manager.

### Downloading and Applying

Clone the repo to your computer, i prefer it to be saved in `~/.dotfiles`:

```bash
git clone https://git.sr.ht/~sofi/dotfiles ~/.dotfiles
cd ~/.dotfiles/configs
```

You can now use `stow --verbose --stow --target=$HOME FOLDER_NAME` to
apply any of the available folders inside of `configs/`.

There is also a easy to use `install.sh` and `remove.sh` that use the `enabled`
file to install my currently in use configurations.

### Removing

Use `stow --delete --target=$HOME $FOLDER` to remove any installed stows.

If you used `install.sh`, you can just use `remove.sh` to do the same
automatically.


## Keyboard

This is my custom keyboard remapping solution. It allows me to rebind keys like
Capslock to become both ESC and CTRL depending on if i hold the key down or
just tap it.

Usually this is done keyboard side with software, for example with
[QMK](https://qmk.fm/). But my keyboard is an old IBM Thinkpad travel keyboard,
which does not have such niceties. So I am doing it trough software with
[dual-function-keys](https://gitlab.com/interception/linux/plugins/dual-function-keys)
and [interception-tools](https://gitlab.com/interception/linux/tools).
This has the added benefit of working on any keyboard, including the built in
one on my laptop.
