#!/bin/bash

while read -r line; do stow --verbose --delete --target=$HOME $line; done < ./enabled
