#!/usr/bin/env bash

TOOLCHAIN_NAME=TOOLCHAIN_NAME_TODO

if [ -n "$1" ] && [ "$1" == "-f" ]; then
    echo "Installation toolchain: $TOOLCHAIN_NAME"
else
    read -p "Do you want to Install the toolchain? [Y/n]: " choice
    if [[ -z "$choice" || "$choice" == "y" || "$choice" == "Y" ]]; then
        echo "Installation toolchain: $TOOLCHAIN_NAME"
    elif [[ "$choice" == "n" || "$choice" == "N" ]]; then
        echo "Installation cancelled."
        exit 0
    else
        echo "Invalid choice. Please enter 'y' or 'n'."
        exit 1
    fi
fi

cp -r $TOOLCHAIN_NAME $HOME/.rustup/toolchains/
echo "Installation done!"
