#!/bin/sh
set -e

dconf load /org/cinnamon/ < $PWD/../configs/cinnamon-dconf
ln -s "$PWD/../configs/gtk.css" ~/.config/gtk-3.0/gtk.css
