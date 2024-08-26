#!/usr/bin/env bash

param1=${1:-}

export RUST_COMMIT=5ef9e3d85d934b27d9dada2f9dd52b1dc63bb04

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

# Toolchain itself does not need to be versioned by default. It makes referencing it from
# various other projects harder while things are in development. Version can be queried by
# calling `rustc --version anyways`. If someone needs to keep an older version they can 
# always rename the folder at install time.
export TOOLCHAIN_NAME=rve-nightly

# Artifact name should be versioned as it is only used at install time.
export ARTIFACT_NAME=rust-rve-nightly-$rust_commit_date-$TOOLCHAIN_HOST_TRIPLET

if [ "$param1" == "-artifact_name" ]; then
    echo "ARTIFACT_NAME=$ARTIFACT_NAME" >> $GITHUB_ENV
fi

