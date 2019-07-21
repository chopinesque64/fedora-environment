#!/bin/sh

sudo dnf install redshift -y
ln -sf $PWD/../configs/redshift.conf ~/.config
sudo ln -sf /usr/share/applications/redshift-gtk.desktop ~/.config/autostart
