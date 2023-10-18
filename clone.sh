#!/usr/bin/env bash

set -euo pipefail

git clone "https://github.com/rust-lang/rust.git"
cd rust
# This could change if the patch will be updated
git checkout 8d321f7a88f0ae27793c133390e507bf1f49125a
git submodule update --init --recursive
