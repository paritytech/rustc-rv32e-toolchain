#!/usr/bin/env bash

param1=${1:-}

export RUST_COMMIT=8d321f7a88f0ae27793c133390e507bf1f49125a

# If -rust_commit specified then only export the rust commit variable
if [ "$param1" == "-rust_commit" ]; then
  return
fi

export TOOLCHAIN_HOST_TRIPLET=$(rustc --version --verbose | grep 'host: ' | sed -r 's/host: (.*)/\1/')

cd rust
git show --no-patch --format=%ci $RUST_COMMIT > commit_show_output
commit_show_output=$(cat commit_show_output)
rm commit_show_output
cd ../

regex='([0-9]{4}-[0-9]{2}-[0-9]{2})'
if [[ $commit_show_output =~ $regex ]]; then
  rust_commit_date="${BASH_REMATCH[1]}"
else
  echo "Impossible extracting date from rustc commit"
  exit 1
fi

export TOOLCHAIN_NAME=rv32e-nightly-2023-04-05
export TOOLCHAIN_VERSION=nightly-$rust_commit_date-r$(cat release_number)
export TOOLCHAIN_VERSION_NAME=riscv32em-$TOOLCHAIN_VERSION-$TOOLCHAIN_HOST_TRIPLET
export FOLDER_NAME=rust-riscv32em-$TOOLCHAIN_HOST_TRIPLET
export ARTIFACT_NAME=rust-$TOOLCHAIN_VERSION_NAME

if [ "$param1" == "-artifact_name" ]; then
    echo "ARTIFACT_NAME=$ARTIFACT_NAME" >> $GITHUB_ENV
fi

