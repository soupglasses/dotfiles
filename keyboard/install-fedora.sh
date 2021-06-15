#!/bin/bash

sudo dnf copr enable fszymanski/interception-tools &&
sudo dnf install -y interception-tools dual-function-keys &&

sudo mkdir -p /etc/interception &&

. ./apply.sh &&

sudo systemctl enable udevmon
