#!/bin/sh
set -e

mkdir -p ~/bin
wget -qO- http://www.styluslabs.com/write/write209.tar.gz | tar -C ~/bin -xvz
wget https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Icon-notepad.svg/256px-Icon-notepad.svg.png -O ~/bin/Write/write.png
sudo ln -sf $PWD/../configs/Write.desktop /usr/share/applications 
