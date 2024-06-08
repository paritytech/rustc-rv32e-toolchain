#!/usr/bin/env bash

set -euo pipefail

source config.sh

TOOLCHAIN_DIR=rust/build/$TOOLCHAIN_HOST_TRIPLET/stage2
cp -n rust/build/$TOOLCHAIN_HOST_TRIPLET/stage2-tools-bin/* $TOOLCHAIN_DIR/bin
tar --exclude lib/rustlib/src --exclude lib/rustlib/rustc-src -hczvf rust-toolchain-$TOOLCHAIN_NAME.tar.gz -C $TOOLCHAIN_DIR .
