#!/bin/sh
set -e

sudo dnf install zsh -y

sudo wget -O /etc/zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
sudo ln -sf "$PWD/../configs/zshrc.local" ~/.zshrc
chsh --shell $(which zsh) $USER
