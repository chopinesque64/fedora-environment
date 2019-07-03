#!/bin/sh

mkdir ~/bin
ln -s /run/media ~/media/$USER

# Package Installation
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install curl \ 
vim \
docker \
docker-compose \
zsh \
emacs \
firefox \
gcc \
fuse-exfat \
BasiliskII

# Rust
type rustup >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup toolchain add nightly
cargo +nightly install racer
rustup component add rust-src

# TeX Live
TEMP=$(mktemp -d)
wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar -C $TEMP -xvz
sudo $TEMP/install-tl-*/install-tl

# Cinnamon
dconf load /org/cinnamon/ < configs/cinnamon-dconf
ln -s "$PWD/configs/gtk.css" ~/.config/gtk-3.0/gtk.css

# Vim
ln -sf "$PWD/configs/vimrc" ~/.vimrc
mkdir ~/.vim/colors
wget
https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
~/.vim/colors/

# Git
sudo ln -sf "$PWD/configs/post-commit" /usr/share/git-core/templates/hooks/
ln -sf configs/gitignore ~/.gitignore
git config --global credential.helper "cache --timeout=3600"
git config --global push.default simple
git config --global user.email ngentry1@liberty.edu
git config --global user.name "Nathanael Gentry"
git config --global user.signingkey 4C7C95EC9EF26D41 
git config --global commit.gpgsign true
git config --global core.excludesfile ~/.gitignore

# Docker
sudo systemctl enable docker

# Zsh
sudo wget -O /etc/zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
sudo ln -sf "$PWD/configs/zshrc.local" ~/.zshrc
chsh --shell $(which zsh) $USER

# Emacs
mkdir ~/.emacs.d
ln -sf "$PWD/configs/init.el" ~/.emacs.d/
sudo ln -sf /usr/share/applications/emacs.desktop ~/.config/autostart/

# Firefox
ln -sf "$PWD/configs/user.js" $(find ~/.mozilla/firefox -type d -name "*.default" -print -quit)

# BasiliskII
ln -sf "$PWD/configs/basilisk_ii_prefs" ~/.basilisk_ii_prefs

# Dropbox
TEMP=$(mktemp -d)
wget 'https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2019.02.14-1.fedora.x86_64.rpm' -O $TEMP/dropbox.rpm
sudo dnf install -y $TEMP/dropbox.rpm

git clone https://github.com/dark/dropbox-filesystem-fix.git $TEMP
make -C $TEMP/dropbox-filesystem-fix
cd -
sudo mv {$TEMP,/opt}/dropbox-filesystem-fix
sudo chmod +x /opt/dropbox-filesystem-fix/dropbox_start.py
sudo ln -sf configs/dropbox-filesystem-fix.desktop ~/.config/autostart

# Zotero
wget -qO- https://download.zotero.org/client/release/5.0.69/Zotero-5.0.69_linux-x86_64.tar.bz2 | tar -C ~/bin -xvj
sed -i "s|zotero.ico|$HOME/bin/Zotero_linux-x86_64/chrome/icons/default/default32.png" ~/bin/Zotero_linux-x86_64/zotero.desktop
sudo ln -sf ~/bin/Zotero_linux-x86_64/zotero.desktop /usr/share/applications
sudo chmod 644 /usr/share/applications/zotero.desktop
