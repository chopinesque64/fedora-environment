#!/bin/sh
set -e

sudo dnf install BasiliskII -y

stow --target=$HOME BasiliskII
