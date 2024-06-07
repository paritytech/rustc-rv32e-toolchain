#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Will create component archives (dists) ./rust/build/dist
cd rust
CARGO_TARGET_RISCV32EM_ATHENA_ZKVM_ELF_RUSTFLAGS="-Cpasses=loweratomic" ./x dist rustc rust-std cargo rust-src rustfmt clippy --target $TOOLCHAIN_HOST_TRIPLET,riscv32em-athena-zkvm-elf
