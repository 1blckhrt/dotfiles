#!/bin/bash

install_pip_modules() {
    echo -e '[INFO] Installing pip modules...'
    pip3 install --user i3ipc
}

install_pip_modules