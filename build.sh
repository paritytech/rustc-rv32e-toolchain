#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Rust requires a custom target file to exist for our custom target as part of the bootstrap build,
# but it doesn't actually look at the contents.
touch /tmp/riscv32em-athena-zkvm-elf.json

# Will create component archives (dists) ./rust/build/dist
cd rust
#RUSTFLAGS="-C link-arg=-L$HOME/compiler_rt_build_riscv32em-athena-zkvm-elf/lib/baremetal" \
#LIBRARY_PATH="$HOME/compiler_rt_build_riscv32em-athena-zkvm-elf/lib/baremetal" \
RUST_TARGET_PATH="/tmp" \
CARGO_TARGET_RISCV32EM_ATHENA_ZKVM_ELF_RUSTFLAGS="-Cpasses=loweratomic" \
CFLAGS_riscv32em_athena_zkvm_elf="-ffunction-sections -fdata-sections -fPIC -march=rv32em -mabi=ilp32e" \
./x build --stage 2
