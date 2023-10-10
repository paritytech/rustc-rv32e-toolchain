#!/usr/bin/env bash

set -euo pipefail

cd rust
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
./x dist

# The output of the compilation shoudl be in ../../rust/build/dist
