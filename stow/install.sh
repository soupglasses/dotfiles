#!/bin/bash

while read -r line; do stow --verbose --stow --target=$HOME $line; done < ./enabled
