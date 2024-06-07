#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Will create component archives (dists) ./rust/build/dist
cd rust
CARGO_TARGET_RISCV32EM_ATHENA_ZKVM_ELF_RUSTFLAGS="-Cpasses=loweratomic" ./x build
CARGO_TARGET_RISCV32EM_ATHENA_ZKVM_ELF_RUSTFLAGS="-Cpasses=loweratomic" ./x build --stage 2
