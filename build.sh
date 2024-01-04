#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Will create component archives (dists) ./rust/build/dist
cd rust
./x dist rustc rust-std cargo rust-src rustfmt clippy --target riscv32em-unknown-none-elf
