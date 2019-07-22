#!/bin/sh
set -e

sudo dnf install emacs -y

sudo ln -sf /usr/share/applications/emacs.desktop ~/.config/autostart/
