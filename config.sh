#!/usr/bin/env bash

param1=${1:-}

export RUST_COMMIT=051478957371ee0084a7c0913941d2a8c4757bb9

# If -rust_commit specified then only export the rust commit variable
if [ "$param1" == "-rust_commit" ]; then
  return
fi

export TOOLCHAIN_HOST_TRIPLET=$(rustc --version --verbose | grep 'host: ' | sed -r 's/host: (.*)/\1/')

# Artifact name should be versioned as it is only used at install time.
export ARTIFACT_NAME=athena-rust-toolchain-$TOOLCHAIN_HOST_TRIPLET

if [ "$param1" == "-artifact_name" ]; then
    echo "ARTIFACT_NAME=$ARTIFACT_NAME" >> $GITHUB_ENV
fi

need_cmd() {
  if ! check_cmd "$1"; then
    err "need '$1' (command not found)"
  fi
}

check_cmd() {
  command -v "$1" &>/dev/null
}

say() {
  printf "rustc-rv32e-toolchain: %s\n" "$1"
}

warn() {
  say "warning: ${1}" >&2
}

err() {
  say "$1" >&2
  exit 1
}
