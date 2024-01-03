# Compiled Rust Toolchain for RV32E

This repository compile and publish as release final binaries of the Rust toolchain targetting RISC-V RV32E.

## Download 

``` sh
# Download the latest release from the release page.
tar --zstd -xf rust-rve-nightly-2023-04-05-aarch64-apple-darwin.tar.zst
mv rve-nightly ~/.rustup/toolchains/
```

## Build with `ci-unified`

If there is a need to build the toolchain using [Parity default CI environment](https://github.com/paritytech/scripts/tree/master/dockerfiles/ci-unified), tweak the build step as follows:

```
export CXX=/usr/bin/clang++-15
./build.sh --DCMAKE_BUILD_TYPE=Release
```
