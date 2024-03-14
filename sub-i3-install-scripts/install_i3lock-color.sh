#!/bin/bash

install_i3lock-color() {
    echo -e '[INFO] Installing i3lock-color...'

    git clone https://github.com/Raymo111/i3lock-color.git $USERDIR/
    cd $USERDIR/i3lock-color
    chmod +x ./install-i3lock-color.sh
    ./install-i3lock-color.sh
}

install_i3lock-color