#!/bin/sh

# Git Configuration
git config --global credential.helper "cache --timeout=3600"
git config --global push.default simple
git config --global user.email ngentry1@liberty.edu
git config --global user.name "Nathanael Gentry"
git config --global user.signingkey 4C7C95EC9EF26D41 
git config --global commit.gpgsign true

# Guake
sudo dnf install guake
sudo ln -sf /usr/share/applications/guake.desktop ~/.config/autostart/

# Docker
sudo dnf install docker docker-compose
sudo systemctl enable docker

# Zsh
sudo dnf install zsh
sudo ln -sf "$PWD/configs/zshrc.system" /etc/zshrc
sudo ln -sf "$PWD/configs/zshrc.local" ~/.zshrc
chsh --shell $(which zsh) $USER

# Emacs
sudo dnf install emacs
mkdir ~/.emacs.d
ln -sf "$PWD/configs/init.el" ~/.emacs.d/

# Firefox
sudo dnf install firefox
ln -sf "$PWD/configs/user.js" $(find ~/.mozilla/firefox -type d -name "*.default" -print -quit)
