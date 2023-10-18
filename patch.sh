#!/usr/bin/env bash

set -euo pipefail

cd rust
patch -p1 < ../patches/rust.patch
cp ../patches/config.toml ./

cd src/llvm-project
patch -p1 < ../../../patches/llvm-D70401.patch
patch -p1 < ../../../patches/compiler-rt.patch
