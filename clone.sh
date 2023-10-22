#!/usr/bin/env bash

set -euo pipefail

source config.sh -rust_commit

git clone "https://github.com/rust-lang/rust.git"
cd rust
# This could change if the patch will be updated
git checkout $RUST_COMMIT
git submodule update --init --recursive
