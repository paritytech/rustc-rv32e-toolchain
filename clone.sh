#!/usr/bin/env bash

set -euo pipefail

source config.sh -rust_commit

git clone "https://github.com/succinctlabs/rust.git" --depth 1 --single-branch --branch succinct
cd rust
git fetch --depth 1 origin $RUST_COMMIT
git checkout FETCH_HEAD
git submodule update --init --recursive --depth 1
