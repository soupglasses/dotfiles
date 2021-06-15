#!/usr/bin/env bash

while read -r line; do stow --verbose --stow --ignore=README.md --ignore=EXAMPLES --target=$HOME $line; done < ./enabled
