#!/bin/sh

sudo dnf install firefox -y

 profile_default = $(find ~/.mozilla/firefox -type d -name "*.default" -print -quit)
 stow --target=profile_default firefox
