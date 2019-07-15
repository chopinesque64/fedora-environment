#!/bin/sh
set -e

sudo dnf install BasiliskII -y

ln -sf "$PWD/../configs/basilisk_ii_prefs" ~/.basilisk_ii_prefs
