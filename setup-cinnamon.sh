#!/bin/sh
set -e

dconf load /org/cinnamon/ < $PWD/../configs/cinnamon-dconf
stow --target=$HOME .config
