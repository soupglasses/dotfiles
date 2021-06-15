#!/bin/bash

ARGS="-o root -g root -m 0644"

sudo install $ARGS \
    udevmon.yaml \
    /etc/interception/udevmon.yaml

sudo install $ARGS \
    ibm_keyboard.yaml \
    /etc/interception/ibm_keyboard.yaml
