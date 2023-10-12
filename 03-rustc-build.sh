#!/usr/bin/env bash

set -euo pipefail

cd rust
# library flag avoid compiling rustdoc
# stage 1 must be specified otherwise in CI the build sript expect stage 2
./x build library --stage 1
