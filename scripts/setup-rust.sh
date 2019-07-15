#!/bin/sh
set -e

sudo dnf install curl -y

type rustup >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup toolchain add nightly
cargo +nightly install racer
rustup component add rust-src
