#!/bin/sh
set -e

sudo dnf install git -y

stow --target=$HOME git
