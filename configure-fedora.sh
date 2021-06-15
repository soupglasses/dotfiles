#!/bin/bash

sudo dnf update --refresh &&

sudo sed -i 's/SoftwareSourceSearch=true/SoftwareSourceSearch=false/g' /etc/PackageKit/CommandNotFound.conf &&

sudo dnf install -y grc util-linux-user gparted sqlite foliate fzf gimp vlc zsh trash-cli toilet tealdeer ripgrep python python3-pandas pipenv peek pulseaudio-utils pavucontrol obs-studio nmap neofetch maim kitty java-latest-openjdk gnome-epub-thumbnailer fira-code-fonts evolution audacity gnome-tweaks firewall-config npm stow git gpg wl-clipboard neovim youtube-dl unzip p7zip &&

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm &&

sudo dnf groupupdate -y Multimedia && 

sudo dnf groupinstall -y "Development Tools" &&

git clone https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
