# Nix and Home-Manager for non-NixOS systems

What is Nix?

> Nix is a cross-platform package manager that utilizes a purely functional deployment model where software is installed into unique directories generated through cryptographic hashes. It is also the name of the tool's programming language. A package's hash takes into account the dependencies, which is claimed to eliminate dependency hell.[2] This package management model advertises more reliable, reproducible, and portable packages.  
[https://en.wikipedia.org/wiki/Nix_(package_manager)](https://en.wikipedia.org/wiki/Nix_(package_manager))

What is Home-Manager?

> Home manager provides a basic system for managing a user environment using the Nix package manager together with the Nix libraries found in Nixpkgs. It allows declarative configuration of user specific (non global) packages and dotfiles.  
[https://github.com/nix-community/home-manager](https://github.com/nix-community/home-manager)

## Installation:

You will need a reasonably up to date nix install. I have attempted to make
this script as backwards compatible as possible.

### Install Nix - Reccomended method

I reccomend you use a distribution-spessific package for Nix. As it is currently
more up to date than the official methods for installing Nix. Plus it ships with
extra helpers to get nix running nicely under non-NixOS enviroments.
This is especially true for SELinux-enabled distros like Fedora and CentOS.

Follow the steps:
[https://nix-community.github.io/nix-installers/](https://nix-community.github.io/nix-installers/).

In short, it would be to run the command below, swapping out with your package
manager of choice:

```bash
$ sudo dnf install ~/Downloads/nix-multi-user-x.x.x.rpm
```

You can safely ignore any warnings about `nixbld` accounts. It is just informing
you that nix is creating its nix-build accounts. These get removed when you run
`sudo dnf remove nix-multi-user`.

### Install Nix - Official method

If you cannot follow the method above, maybe due to running an exotic
operating system that is not packaged above, you can follow the
official instructions here:
[https://nixos.org/download.html](https://nixos.org/download.html).

Do be warned, this is a `.sh` script you run as root! It may mess up your system!

Once installed you will need to add this line into `~/.config/nix/nix.conf`,
or `/etc/nix/nix.conf` if you want it to be system-wide.

```bash
# ~/.config/nix/nix.conf
experimental-features = nix-command flakes
```

This will give you access to the modern `nix` commands (`nix build`/`nix run`),
together with the `nix flake` subset of commands, which are for `flake.nix` and
`flake.lock` files.


### 2. Install home-manager 

ONLY FOLLOW THIS IF YOU WANT HOME-MANAGER, WHICH GIVES YOU A DECLERATIVE DOTFILE
MANAGEMENT SETUP.

Skip to the HOWTO section below if you just want to use nix for its package
management.

---

Now, I need to give you a warning before we continue. This configuration is
my own personal thing, so you cannot simply copy-paste the next few
commands, as it will likely result in error messages and headaches.

I would also reccomend you fork the project if you plan to keep this longer
term.

So first you need to change the `flake.nix` file. In here there will be a
username variable you need to change to your username.

```
    username = "sofi";
```

Next, you will probably have to edit the `home.nix` file. This is a
[home-manager](https://github.com/nix-community/home-manager) configuration
file. It helps helps you build a declarative configuration on a non-NixOS
based distribution. But its also a nice to have on NixOS, but i will skip
that for now.

I would reccomend you to read trough its manual first,
but the main change would be to hook into your shell. Might sound scary at 
first, but you will just move your config file away from its install location,
then use the `initExtra` option to import it back in. Either using 
your shell's source command: `source ~/.dotfiles/.bashrc`. Or use
nix's builtin `builtins.readFile ../.bashrc` which will write in your file's
contents into its own.

But once these changes are done, it should now be possible to run `nix-shell`.
It will install `nixUnstable` for flake support together with `home-manager`
for you. Once its complete, you can run:

```bash
$ home-manager switch --flake .
```

Congratulations, you are now nixing without NixOS!

## HOWTO: Nix

Nix downloads all its binaries to a location called `/nix/store`. So do not be afraid
if you want to run packages you already have installed. Nix will not touch your
normal system install.

For example, you can run htop from `nixpkgs`, the default repository for nix packages.

```
nix run nixpkgs#htop`
```

Now watch closely, as you can watch it download `htop` as well as any dependencies it
will need.

TODO

`nix develop`

`nix build`

`nix build -L`

https://myme.no/posts/2022-01-16-nixos-the-ultimate-dev-environment.html#the-elevator-pitch

`.#`

Direnv

`nix profile`

nixpkgs search

## Maintinence

TODO. Flesh this out more.

```bash
# Show all weakly-linked GC-roots (f.x. result folders that should be manually deleted).
ls -l /nix/var/nix/gcroots/auto/

# Remove all home-manager generations
home-manager expire-generations "-14 days"

# Remove all previous profile generations.
nix profile wipe-history

# Garbage collect all non GC-root derivations.
nix-collect-garbage

# Unlink all previous generations and garbage collect (a handy all-in-one command).
nix-collect-garbage -d
```

## Reccomended reading:

If you are new to Nix, i highly reccomend you to spend an hour reading up on
the topic. As it is wildly different from package managers that you are used
to. If you want to avoid mistakes, and learn how to keep your Nix Store so that
it wont start to eat up all the space on your computer? I can reccomend reading
about it now, and not learn about it later.

"Nix in my development workflow" is a great introduction for those who just
want to get to up to speed with practically using nix.

Do keep in mind that we are using home-manager to manage packages, and not
`nix-env -i`. Plus, upgrades are handled with flakes `nix flake update` instead
of `nix-channel --update`.

[https://medium.com/@ejpcmac/about-using-nix-in-my-development-workflow-12422a1f2f4c](https://medium.com/@ejpcmac/about-using-nix-in-my-development-workflow-12422a1f2f4c)

### Further reading

Then for those who are more interested in learning about Nix, i would reccomend 
also looking at this meta resource with everything you should need to know:
[https://github.com/nix-community/awesome-nix](https://github.com/nix-community/awesome-nix).
