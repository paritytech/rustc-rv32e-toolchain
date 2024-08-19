#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Will create component archives (dists) ./rust/build/dist
cd rust
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x dist rustc rust-std cargo rust-src rustfmt clippy --target $TOOLCHAIN_HOST_TRIPLET,riscv32em-unknown-none-elf,riscv32ema-unknown-none-elf,riscv64ema-unknown-none-elf
