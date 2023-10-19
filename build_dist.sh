#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Build dists
cd rust
# TODO: can this be remove?
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
./x dist rustc rust-std cargo rust-src rustfmt clippy --target $TOOLCHAIN_HOST_TRIPLET --target riscv32em-unknown-none-elf
# The output of the compilation shoudl be in ../../rust/build/dist
