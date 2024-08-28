#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Will create component archives (dists) ./rust/build/dist
cd rust

LLVM_TOOLCHAIN_BIN=$PWD/build/$TOOLCHAIN_HOST_TRIPLET/llvm/bin

BOOTSTRAP_SKIP_TARGET_SANITY=1 \
CC=$LLVM_TOOLCHAIN_BIN/clang \
AR=$LLVM_TOOLCHAIN_BIN/llvm-ar \
CFLAGS_riscv32em_unknown_none_elf='--target=riscv32-unknown-none-elf -march=rv32e' \
CFLAGS_riscv32ema_unknown_none_elf='--target=riscv32-unknown-none-elf -march=rv32e' \
CFLAGS_riscv64ema_unknown_none_elf='--target=riscv32-unknown-none-elf -march=rv64e' \
./x dist rustc rust-std cargo rust-src rustfmt clippy --target $TOOLCHAIN_HOST_TRIPLET,riscv32em-unknown-none-elf,riscv32ema-unknown-none-elf,riscv64ema-unknown-none-elf
