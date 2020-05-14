#!/bin/bash

dnf update --refresh &&

read -p "Press enter to do setup" &&

hostnamectl set-hostname --static navi &&

sed -i 's/SoftwareSourceSearch=true/SoftwareSourceSearch=false/g' /etc/PackageKit/CommandNotFound.conf &&

echo '
defaultyes=1
fastestmirror=1
max_parallel_downloads=10' | tee -a /etc/dnf/dnf.conf &&

cat /etc/dnf/dnf.conf &&

dnf install -y gnome-tweaks firewall-config npm thefuck stow git gpg wl-clipboard pass vim youtube-dl vlc unzip p7zip &&

dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm &&

dnf groupupdate -y Multimedia &&

dnf install -y gstreamer1-plugins-base gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer1-plugins-ugly gstreamer1-plugins-good gstreamer1-plugins-good-extras gstreamer1-plugins-bad-freeworld ffmpeg gstreamer-ffmpeg
