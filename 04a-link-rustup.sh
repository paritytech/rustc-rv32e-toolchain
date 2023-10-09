#!/usr/bin/env bash

set -euo pipefail

source config.sh

rustup toolchain link $TOOLCHAIN_NAME $(pwd)/rust/build/host/stage1
