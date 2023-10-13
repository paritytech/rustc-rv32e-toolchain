#!/usr/bin/env bash

set -euo pipefail

# Build dists
cd rust
# TODO: can this be remove?
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
./x dist library
# The output of the compilation shoudl be in ../../rust/build/dist

#DEBUG
ls -R

# Compress required dists
cd build/dist/
tar -zcf dist_output.tar.gz \
    rustc-nightly-x86_64-unknown-linux-gnu.tar.gz \
    rustc-nightly-x86_64-unknown-linux-gnu.tar.gz \
    rust-dev-nightly-x86_64-unknown-linux-gnu.tar.gz \
    rust-std-nightly-x86_64-unknown-linux-gnu.tar.gz \
    rust-std-nightly-riscv32em-unknown-none-elf.tar.gz \
    cargo-nightly-x86_64-unknown-linux-gnu.tar.gz \
    rust-src-nightly.tar.gz \
    rustfmt-nightly-x86_64-unknown-linux-gnu.tar.gz \
    clippy-nightly-x86_64-unknown-linux-gnu.tar.gz
    # rustc-docs-nightly-x86_64-unknown-linux-gnu.tar.gz \
    # rustc-docs-nightly-riscv32em-unknown-none-elf.tar.gz
