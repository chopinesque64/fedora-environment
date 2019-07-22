#!/bin/sh
set -e

sudo dnf install zsh -y

sudo wget -O ~/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
stow --target=$HOME zsh
chsh --shell $(which zsh) $USER
