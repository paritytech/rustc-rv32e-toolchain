#!/usr/bin/env bash

set -euo pipefail

cd rust
# library flag avoid to compile rustdoc
./x build library
