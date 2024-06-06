#!/usr/bin/env bash

set -euo pipefail

source config.sh

# We generally remove files as soon as we don't need them
# anymore to minimize disk space usage. Especially important for github runners
# which don't have much space.

inst () {
    echo "Installing: $1"
    tar -xf ../$1.tar.gz
    # eager remove to reduce max disk space used
    rm ../$1.tar.gz
    cd $1
    ./install.sh --disable-ldconfig --prefix="" --destdir="/tmp/$TOOLCHAIN_NAME"
    cd ../
}

# dist contains the tared components we want to install
mv rust/build/dist .
rm -rf rust

cd dist
mkdir unpack
cd unpack

inst "rustc-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-std-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-std-nightly-riscv32em-athena-zkvm-elf"
inst "cargo-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-src-nightly"
inst "rustfmt-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "clippy-nightly-$TOOLCHAIN_HOST_TRIPLET"

cd ..
rm -rf unpack

cd ../

# remove the /tmp/ prefix from the manifest to make it path independent
sed -i'' -e "s#/tmp/$TOOLCHAIN_NAME/##g" /tmp/$TOOLCHAIN_NAME/lib/rustlib/manifest-*
rm -f /tmp/$TOOLCHAIN_NAME/lib/rustlib/install.log

# the final toolchain tar that can just be extracted anywhere to install it
tar --zstd -cf $ARTIFACT_NAME.tar.zst -C /tmp $TOOLCHAIN_NAME

rm -rf dist
rm -rf /tmp/$TOOLCHAIN_NAME
