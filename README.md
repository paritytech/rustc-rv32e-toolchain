# Compiled Rust Toolchain for RV32E

This repository compile and publish as release final binaries of the Rust toolchain targetting RISC-V RV32E.

The target triplet is: riscv32em-unknown-none-elf.


Currently the final binary is published as artifact of the GitHub Action, it is compiled only for Linux x86_64.

## Download 

The toolchain can be downloaded by the last action artifact

## Install 

You just need to download the install `install_toolchain.sh` script and put it the same folder with the file containing the toolchain `rv32e_dist.zip`, and then:

``` sh
./install_toolchain
```
