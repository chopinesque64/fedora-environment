#!/bin/sh

TEMP=$(mktemp -d)
wget 'https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2019.02.14-1.fedora.x86_64.rpm' -O $TEMP/dropbox.rpm
sudo dnf install -y $TEMP/dropbox.rpm

git clone https://github.com/dark/dropbox-filesystem-fix.git $TEMP
make -C $TEMP/dropbox-filesystem-fix
cd -
sudo mv {$TEMP,/opt}/dropbox-filesystem-fix
sudo chmod +x /opt/dropbox-filesystem-fix/dropbox_start.py
sudo ln -sf configs/dropbox-filesystem-fix.desktop ~/.config/autostart
