#!/usr/bin/env bash

set -euo pipefail

source config.sh

# Will create component archives (dists) ./rust/build/dist
cd rust

LLVM_TOOLCHAIN_BIN=$PWD/build/$TOOLCHAIN_HOST_TRIPLET/llvm/bin

if [ ! -d $LLVM_TOOLCHAIN_BIN ]; then
	# Bootstrap stage0 C toolchain. These will later be overwritten by the LLVM `clang` build
	REAL_AR=`which ar`
	REAL_CC=`which cc`
	if [ "x$REAL_CC" == "x" ]; then
		REAL_CC=`which clang`
	fi
	mkdir -p $LLVM_TOOLCHAIN_BIN
	cat >$LLVM_TOOLCHAIN_BIN/clang << EOF
#!/bin/bash
$REAL_CC "\$@"
EOF

	cat >$LLVM_TOOLCHAIN_BIN/llvm-ar <<EOF
#!/bin/bash
$REAL_AR "\$@"
EOF

	chmod +x $LLVM_TOOLCHAIN_BIN/clang $LLVM_TOOLCHAIN_BIN/llvm-ar
fi

BOOTSTRAP_SKIP_TARGET_SANITY=1 \
CC=$LLVM_TOOLCHAIN_BIN/clang \
AR=$LLVM_TOOLCHAIN_BIN/llvm-ar \
CFLAGS_riscv32em_unknown_none_elf='--target=riscv32-unknown-none-elf -march=rv32em' \
CFLAGS_riscv32ema_unknown_none_elf='--target=riscv32-unknown-none-elf -march=rv32ema' \
CFLAGS_riscv64ema_unknown_none_elf='--target=riscv32-unknown-none-elf -march=rv64ema' \
./x dist rustc rust-std cargo rust-src rustfmt clippy --target $TOOLCHAIN_HOST_TRIPLET,riscv32em-unknown-none-elf,riscv32ema-unknown-none-elf,riscv64ema-unknown-none-elf
