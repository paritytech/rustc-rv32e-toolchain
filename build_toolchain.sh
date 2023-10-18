#!/usr/bin/env bash

set -euo pipefail

source config.sh

inst () {
    echo "Installing: $1"
    tar -xf ../$1.tar.xz
    cd $1
    ./install.sh --disable-ldconfig --prefix="" --destdir="/tmp/destdir/$TOOLCHAIN_NAME"
    cd ../
}

cd rust/build/dist/
mkdir unpack
cd unnpack

inst "rustc-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz"
inst "rust-std-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz"
inst "rust-std-nightly-riscv32em-unknown-none-elf.tar.xz"
inst "cargo-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz"
inst "rust-src-nightly.tar.xz"
inst "rustfmt-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz"
inst "clippy-nightly-$TOOLCHAIN_HOST_TRIPLET.tar.xz"

# clean up the manifests and remove the install log
sed -i "s/\/tmp\/destdir\/$TOOLCHAIN_NAME\///g" /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/manifest-*
rm -f /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/install.log

# cp install.sh /tmp/destdir/

tar -zcf $TOOLCHAIN_NAME.tar.xz /tmp/destdir/$TOOLCHAIN_NAME install.sh
