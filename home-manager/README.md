# Nix and Home-manager for legacy systems

> Nix is a cross-platform package manager that utilizes a purely functional deployment model where software is installed into unique directories generated through cryptographic hashes. It is also the name of the tool's programming language. A package's hash takes into account the dependencies, which is claimed to eliminate dependency hell.[2] This package management model advertises more reliable, reproducible, and portable packages.  
[https://en.wikipedia.org/wiki/Nix_(package_manager)](https://en.wikipedia.org/wiki/Nix_(package_manager))

> Home manager provides a basic system for managing a user environment using the Nix package manager together with the Nix libraries found in Nixpkgs. It allows declarative configuration of user specific (non global) packages and dotfiles.  
[https://github.com/nix-community/home-manager](https://github.com/nix-community/home-manager)

## Installation:

You will need a reasonably up to date nix install. I have attempted to make
this script as backwards compatible as possible.

### 1. Install nix

#### Reccomended method

Use a distribution packaged Nix. It is currently more up to date than
the official methods for installing Nix. Plus it ships with extra patches to help 
running nix nicely. Especially for SELinux-enabled distros.

Follow the steps:
[https://nix-community.github.io/nix-installers/](https://nix-community.github.io/nix-installers/).

TL;DR would be to run this command, swapping out with your package manager
of choice:

```bash
$ sudo dnf install ~/Downloads/nix-multi-user-x.x.x.rpm
```

You can ignore any warnings about nixbld accounts. It seems intentional.

#### Alternative method

If you cannot follow the method above, maybe due to running an exotic
operating system, or simply that the above option failed. You can follow the
official instructions here:
[https://nixos.org/download.html](https://nixos.org/download.html).

Do be warned, this is an install script and may mess up your system!

### 2. Install home-manager 

Now, I need to give you a warning before we continue. This configuration is
my own personal thing, so you cannot simply copy-paste the next few
commands, as it will likely result in error messages and headaches.

So first you need to change the `flake.nix` file. In here there will be a
username variable you need to change to your username.

```nix
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
