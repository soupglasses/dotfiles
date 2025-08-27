# Dual function keys

This is my custom keyboard remapping solution. It allows me to rebind keys like
Capslock to become both ESC and CTRL depending on if you hold the key down or
just tap it.

Usually this is done keyboard side with software, for example with
[QMK](https://qmk.fm/). But with [dual-function-keys](https://gitlab.com/interception/linux/plugins/dual-function-keys), you can do this to any keyboard, like an old IBM Thinkpad travel keyboard.

Dual function keys uses [interception-tools](https://gitlab.com/interception/linux/tools) under the hood to intercept the keyboard presses. This is how it can work universally for any keyboard.

Of note, changing Capslock to be both left control and escape is extremely
helpful under vim, as escape is the button for going out of its many modes.
