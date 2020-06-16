#!/bin/bash

stow -vSt ~ bash &&
stow -vSt ~ scripts &&
stow -vSt ~ vim &&

# For bash
mkdir -p ~/.npm-global &&

# For vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
echo "Write ':PluginInstall' into vim to complete install"
