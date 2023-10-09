#!/usr/bin/env bash

set -euo pipefail

source config.sh

rustup toolchain uninstall $TOOLCHAIN_NAME
