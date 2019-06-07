#!/bin/sh

# Guake
sudo dnf install guake
sudo ln -sf /usr/share/applications/guake.desktop ~/.config/autostart/

# Docker
sudo dnf install docker docker-compose
sudo systemctl enable docker

# Zsh
sudo dnf install zsh
sudo ln -sf "$PWD/configs/zshrc.system" /etc/zshrc
chsh --shell $(which zsh) $USER

# Emacs
sudo dnf install emacs
mkdir ~/.emacs.d
ln -sf "$PWD/configs/init.el" ~/.emacs.d/
