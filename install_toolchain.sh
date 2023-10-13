#!/usr/bin/env bash

set -euo pipefail

TOOLCHAIN_NAME=rv32e-nightly-2023-04-05-x86_64-unknown-linux-gnu

inst () {
    echo "Installing: $1"
    mkdir -p unpack/
    cd unpack/
    tar -xf ../$1.tar.xz
    cd $1
    ./install.sh --disable-ldconfig --prefix=/ --destdir="~/.rustup/toolchains/$TOOLCHAIN_NAME"
    cd ../../
}

# There is currently no way to download artifacts
# after a workflow run finishes in a format other than a zip
# or to download artifact contents individually.
# https://github.com/actions/upload-artifact#zipped-artifact-downloads
mkdir rust_rv32e
cd rust_rv32e
unzip ../rv32e_dist.zip
tar -xf dist_output.tar.gz

inst "rustc-nightly-x86_64-unknown-linux-gnu"
inst "rust-dev-nightly-x86_64-unknown-linux-gnu"
inst "rust-std-nightly-x86_64-unknown-linux-gnu"
inst "rust-std-nightly-riscv32em-unknown-none-elf"
inst "cargo-nightly-x86_64-unknown-linux-gnu"
inst "rust-src-nightly"
inst "rustfmt-nightly-x86_64-unknown-linux-gnu"
inst "clippy-nightly-x86_64-unknown-linux-gnu"
inst "rustc-docs-nightly-x86_64-unknown-linux-gnu"
inst "rustc-docs-nightly-riscv32em-unknown-none-elf"

echo "you can now delete the folder rust_rv32e and the file rv32e_dist.zip"
