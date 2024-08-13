#!/usr/bin/env bash

set -euo pipefail

source config.sh

TOOLCHAIN_DIR=rust/build/$TOOLCHAIN_HOST_TRIPLET/stage2
TOOLS_BIN_DIR=rust/build/$TOOLCHAIN_HOST_TRIPLET/stage2-tools-bin

# Function to copy files, ignoring errors if destination exists
copy_ignore_existing() {
    cp "$1" "$2" 2>/dev/null || true
}

# Copy files from stage2-tools-bin to stage2/bin, ignoring if they already exist
for file in "$TOOLS_BIN_DIR"/*; do
    copy_ignore_existing "$file" "$TOOLCHAIN_DIR/bin/"
done

# Create tarball
tar --exclude lib/rustlib/src --exclude lib/rustlib/rustc-src -hczvf $ARTIFACT_NAME.tar.gz -C $TOOLCHAIN_DIR .
