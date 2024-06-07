# Compiled Rust Toolchain for RV32E

This repository compiles and publishes as release final binaries of the Rust toolchain targeting RISC-V RV32E.

## Building

```sh
./clone.sh
./patch.sh
./build.sh
./package.sh
```

Executing those steps will create a `rust-rve-nightly-$rust_commit_date-$TOOLCHAIN_HOST_TRIPLET.xz` in your working directory. See the next chapter about installation how to use this
toolchain with rustup.

## Installation

You can either download a package from the release page or build it yourself with the instructions above. The following steps will make the toolchain available via rustup's
`+rve-nightly` syntax.

``` sh
tar --zstd -xf rust-rve-nightly-$rust_commit_date-$TOOLCHAIN_HOST_TRIPLET.xz
mv rve-nightly ~/.rustup/toolchains/
# Clear the "downloaded" attribute recursively on macOS to satisfy GateKeeper
xattr -rc ~/.rustup/toolchains/rve-nightly
```

The last step is needed when downloading the binary toolchain with Safari. Otherwise GateKeeper will prevent running downloaded binaries without code signature:

<img width="245" alt="326768663-26a8b06f-5074-485e-9677-12806b0454bd" src="https://github.com/paritytech/rustc-rv32e-toolchain/assets/2580396/5fd140ae-526c-435c-8e6c-ba91a3ab27d3">
