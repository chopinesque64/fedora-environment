#!/bin/sh
set -e

TEMP=$(mktemp -d)
wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar -C $TEMP -xvz
sudo $TEMP/install-tl-*/install-tl
