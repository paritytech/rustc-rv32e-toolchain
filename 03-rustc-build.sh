#!/usr/bin/env bash

set -euo pipefail

cd rust
# Not relly sure why the build in CI require '--stage 2' flag
python x.py build --stage 2
