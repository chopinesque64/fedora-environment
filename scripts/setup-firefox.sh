#!/bin/sh

sudo dnf instal firefox -y

ln -sf "$PWD/configs/user.js" $(find ~/.mozilla/firefox -type d -name "*.default" -print -quit)
