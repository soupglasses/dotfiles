#!/usr/bin/env bash

sudo zypper addrepo --refresh https://download.opensuse.org/repositories/home:/soupglasses/openSUSE_Tumbleweed/home:soupglasses.repo &&
  sudo zypper install -y dual-function-keys

sudo mkdir -p /etc/interception &&
  . ./apply.sh &&
  sudo systemctl enable --now udevmon
