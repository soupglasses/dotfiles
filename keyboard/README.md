# Keyboard Configuration

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

## Requirements

* [dual-function-keys](https://gitlab.com/interception/linux/plugins/dual-function-keys/)
* [interception-tools](https://gitlab.com/interception/linux/tools)
* [A running udevmon daemon](https://gitlab.com/interception/linux/tools#execution)

## Installation

Either follow each README in the requirements above, or if you have Fedora you can run
my `install-fedora.sh` script which will install the needed dependencies, enable them,
and run `apply.sh` to install configurations from `keyboard/configs/`.

## Configuration

Per keyboard configuration is held in `keyboard/configs/`. See
[dual-function-keys examples](https://gitlab.com/interception/linux/plugins/dual-function-keys/-/blob/master/doc/examples.md)
for how to create your own.

You can also follow the
[dual-function-keys README](https://gitlab.com/interception/linux/plugins/dual-function-keys/-/blob/master/README.md)
for how to find out your keyboard id/name if you want to make your configurations
be per keyboard.

After configuring to your keyboard, you can run `apply.sh` as root to install it.
