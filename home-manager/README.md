# Home-manager for legacy systems

## Installation:

You will need a reasonably up to date nix install. I have attempted to make
this script as backwards compatible as possible.

### 1. Install nix

#### Reccomended method

Use a distribution-native packaged nix. It is currently more up to date than
the official method of installing. It also ships with extra patches to help 
running nix under other distributions. Especially for SELinux.

Follow the instructions on here:
[https://nix-community.github.io/nix-installers/](https://nix-community.github.io/nix-installers/).

But it should be as easy as this, swapping out with your package manager
of choice:

```bash
$ sudo dnf install ~/Downloads/nix-multi-user-x.x.x.rpm
```

You can ignore any warnings about nixbld accounts. It seems intentional.

#### Alternative method

If you cannot follow the method above, maybe due to running an exotic
operating system, or simply that the above option failed. You can follow the
official installation instructions for installing Nix from 
[https://nixos.org/download.html](https://nixos.org/download.html).

Do be warned, this is a `.sh` install script and may mess up your system!

### 2. Install home-manager 

Whoa there partner! Slow down. I need to give you a genuine warning before
we continue. This configuration is my own personal config, so simply copy 
pasting the commands below will likely result in error messages and headaches.

Firstly you would need to change the `flake.nix` file. You will need to
change the username variable to your account name.

```nix
    username = "sofi";
```

Then you will probably have to edit the `home.nix` file. This is
[home-manager](https://github.com/nix-community/home-manager).
It is our best alternative to create a declarative configuration on
a non-NixOS based distribution.

You should try to read trough its manual to get a gist of how it works,
but essentially you need to make sure you let it manage your `bash`/`zsh`/`fish`
configuration file. This should not be problematic, just move your
config file away from its install location, and use the `initExtra` option to
import it back in, using either bash's source `source ~/.dotfiles/.bashrc`,
which would let you edit the config file without having to switch home-manager
configurations. Or use `builtins.readFile ../.bashrc` which will read the file
into its own generated file.

But once these changes are done, you should be able to run `nix-shell` in this
folder. This will download `nixUnstable` for flake support, and `home-manager`
for you. Once its done, you can run:

```bash
$ home-manager switch --flake .
```

Congratulations, you are now nixing without NixOS!

## Reccomended reading:

If you are new to Nix, i highly reccomend you to spend an hour reading up on
the topic. As it is wildly different from package managers that you are used
to. If you want to avoid mistakes, and learn how to keep your Nix Store so that
it wont start to eat up all the space on your computer? I can reccomend reading
about it now, and not learn about it later.

Nix for Developers by Gianluca is a great introduction for those who just
want to get to up to speed with its practical use:
[https://gianarb.it/blog/nix-for-developers-sneaking-in-my-toolchain](https://gianarb.it/blog/nix-for-developers-sneaking-in-my-toolchain)

Then for those who are more interested in learning about Nix, i would reccomend 
also looking at this meta resource with everything you should need to know:
[https://github.com/nix-community/awesome-nix](https://github.com/nix-community/awesome-nix).
