#!/bin/sh
set -e

sudo dnf install git -y

ln -sf configs/gitignore ~/.gitignore
git config --global credential.helper "cache --timeout=3600"
git config --global push.default simple
git config --global user.email ngentry1@liberty.edu
git config --global user.name "Nathanael Gentry"
git config --global user.signingkey 4C7C95EC9EF26D41
git config --global commit.gpgsign true
git config --global core.excludesfile ~/.gitignore
