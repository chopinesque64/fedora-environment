#!/bin/sh

# Package Installation
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install curl \ 
vim \
guake \
docker \
docker-compose \
zsh \
emacs \
firefox \
gcc \
BasiliskII

# Rust
type rustup >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup toolchain add nightly
cargo +nightly install racer
rustup component add rust-src

# Cinnamon
dconf load /org/cinnamon/ < configs/cinnamon-dconf

# Vim
ln -sf "$PWD/configs/vimrc" ~/.vimrc
mkdir ~/.vim/colors
wget
https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
~/.vim/colors/

# Git
git config --global credential.helper "cache --timeout=3600"
git config --global push.default simple
git config --global user.email ngentry1@liberty.edu
git config --global user.name "Nathanael Gentry"
git config --global user.signingkey 4C7C95EC9EF26D41 
git config --global commit.gpgsign true
sudo ln -sf "$PWD/configs/post-commit" /usr/share/git-core/templates/hooks/

# Guake
sudo ln -sf /usr/share/applications/guake.desktop ~/.config/autostart/
gconftool-2 --load configs/apps-guake.xml
gconftool-2 --load configs/schemas-apps-guake.xml

# Docker
sudo systemctl enable docker

# Zsh
sudo ln -sf "$PWD/configs/zshrc.system" /etc/zshrc
sudo ln -sf "$PWD/configs/zshrc.local" ~/.zshrc
chsh --shell $(which zsh) $USER

# Emacs
mkdir ~/.emacs.d
ln -sf "$PWD/configs/init.el" ~/.emacs.d/
sudo ln -sf /usr/share/applications/emacs.desktop ~/.config/autostart/

# Firefox
ln -sf "$PWD/configs/user.js" $(find ~/.mozilla/firefox -type d -name "*.default" -print -quit)
