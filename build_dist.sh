#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Build dists
cd rust
# TODO: can this be remove?
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
./x dist rustc rust-std cargo rust-src rustfmt clippy --target $TOOLCHAIN_HOST_TRIPLET --target riscv32em-unknown-none-elf
# The output of the compilation shoudl be in ../../rust/build/dist


# Compress required dists
cd build/dist/
ls
tar -zcf dist_output.tar.gz \
    rustc-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-std-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-std-nightly-riscv32em-unknown-none-elf.tar.xz \
    cargo-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-src-nightly.tar.xz \
    rustfmt-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    clippy-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz
