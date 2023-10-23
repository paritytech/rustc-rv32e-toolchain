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

df -h
mv rust/build/dist .
# remove rust to have some space to create the toolchain
rm -r rust
df -h

cd dist
mkdir unpack
cd unpack

inst "rustc-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-std-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-std-nightly-riscv32em-unknown-none-elf"
inst "cargo-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-src-nightly"
inst "rustfmt-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "clippy-nightly-$TOOLCHAIN_HOST_TRIPLET"

cd ../../

# clean up the manifests and remove the install log
sed -i'' -e "s#/tmp/destdir/$TOOLCHAIN_NAME/##g" /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/manifest-*
rm -f /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/install.log

# Create Artifact folder
mkdir $FOLDER_NAME
# copy toolchain
cp -r /tmp/destdir/$TOOLCHAIN_NAME $FOLDER_NAME

# Meta install
sed -i'' -e "s#TOOLCHAIN_NAME_VARIABLE#$TOOLCHAIN_NAME#g" install.sh

# copy install script
cp install.sh $FOLDER_NAME

# compress the final artifact
tar -zcf $ARTIFACT_NAME.tar.xz $FOLDER_NAME
