#!/usr/bin/env bash

# TODO: this is executed BEFORE building rustc, this mean that
# rustc is already installed on the machine if this work

export TOOLCHAIN_HOST_TRIPLET=$(rustc --version --verbose | grep 'host: ' | sed -r 's/host: (.*)/\1/')

# TODO: maybe this should be updated with `nightly-2023-04-05-r1`
export TOOLCHAIN_VERSION=$(rustc --version --verbose | grep 'release: ' | sed -r 's/release: (.*)/\1/')-r$(cat release_number)

export TOOLCHAIN_NAME=riscv32em-$TOOLCHAIN_VERSION-$TOOLCHAIN_HOST_TRIPLET
export ARTIFACT_NAME=rust-$TOOLCHAIN_NAME

if [ -n "$1" ] && [ "$1" == "-artifact_name" ]; then
    echo "ARTIFACT_NAME=$ARTIFACT_NAME" >> $GITHUB_ENV
fi
