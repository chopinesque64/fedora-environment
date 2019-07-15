#!/bin/sh
set -e

sudo dnf install vim -y

ln -sf "$PWD/../configs/vimrc" ~/.vimrc
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim ~/.vim/colors/
