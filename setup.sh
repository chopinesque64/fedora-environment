#!/bin/sh

sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

cd scripts
./config-dirs.sh
./setup-zsh.sh
./setup-git.sh
./setup-emacs.sh
./setup-cinnamon.sh
./setup-firefox.sh
./setup-texlive.sh
./setup-BasiliskII.sh
cd -
