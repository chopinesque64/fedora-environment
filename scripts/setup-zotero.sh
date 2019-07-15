#!/bin/sh

wget -qO- https://download.zotero.org/client/release/5.0.69/Zotero-5.0.69_linux-x86_64.tar.bz2 | tar -C ~/bin -xvj
sed -i "s|zotero.ico|$HOME/bin/Zotero_linux-x86_64/chrome/icons/default/default32.png" ~/bin/Zotero_linux-x86_64/zotero.desktop
sudo ln -sf ~/bin/Zotero_linux-x86_64/zotero.desktop /usr/share/applications
sudo chmod 644 /usr/share/applications/zotero.desktop
