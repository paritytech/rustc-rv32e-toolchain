#!/usr/bin/env bash

set -euo pipefail

TOOLCHAIN_HOST_TRIPLET=$(rustc --version --verbose | grep 'host: ' | sed -r 's/host: (.*)/\1/')

# Build dists
cd rust
# TODO: can this be remove?
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
./x dist rustc rust-dev rust-std cargo rust-src rustfmt clippy rustc-docs --target $TOOLCHAIN_HOST_TRIPLET --target riscv32em-unknown-none-elf
# The output of the compilation shoudl be in ../../rust/build/dist


# Compress required dists
cd build/dist/
ls
tar -zcf dist_output.tar.gz \
    rustc-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-dev-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-std-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-std-nightly-riscv32em-unknown-none-elf.tar.xz \
    cargo-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rust-src-nightly.tar.xz \
    rustfmt-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    clippy-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rustc-docs-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz \
    rustc-docs-nightly-riscv32em-unknown-none-elf.tar.xz
