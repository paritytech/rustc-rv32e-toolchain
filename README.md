# Compiled Rust Toolchain for RV32E

This repository compile and publish as release final binaries of the Rust toolchain targetting RISC-V RV32E.

The target triplet is: riscv32em-unknown-none-elf.

Currently the final binary is published as artifact of the GitHub Action, it is compiled only for Linux x86_64.


## Link the Toolchain to rustup

To link the provided toolchain you simply need to:

``` sh
rustup toolchain link rv32e-nightly-2023-04-05-x86_64-unknown-linux-gnu <compiled_rv32e-toolchain>
```

And if you want to unlink it:

``` sh
rustup toolchain uninstall rv32e-nightly-2023-04-05-x86_64-unknown-linux-gnu
```


## Install the Toolchain

TODO
