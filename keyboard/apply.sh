#!/bin/bash

sudo install -o root -g root -m 0644 -D \
    configs/*.yaml \
    /etc/interception &&

sudo systemctl restart udevmon
