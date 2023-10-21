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

mv rust/build/dist .
# remove all the rust folder to save some space
rm -r rust
ls -R
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
# TODO this does not work on macos
# sed -i "s#/tmp/destdir/$TOOLCHAIN_NAME/##g" /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/manifest-*
# maybe this?
# sed -i 's#/tmp/destdir/$TOOLCHAIN_NAME/##g' /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/manifest-*
# this is remove just to be sure it works
# rm -f /tmp/destdir/$TOOLCHAIN_NAME/lib/rustlib/install.log

# Create Artifact folder
mkdir $ARTIFACT_NAME
# copy toolchain
cp -r /tmp/destdir/$TOOLCHAIN_NAME $ARTIFACT_NAME

# Meta install
# TODO: this could be done directly in the file usind sed -i
general_install=$(cat general_install.sh)
install=$(echo -e "$general_install" | sed "s/TOOLCHAIN_NAME_TODO/$TOOLCHAIN_NAME/")
echo -e "$install" > install.sh
chmod +x install.sh

# copy install script
cp install.sh $ARTIFACT_NAME

# compress the final artifact
tar -zcf $ARTIFACT_NAME.tar.xz $ARTIFACT_NAME
