#!/bin/bash

setup_light() {
    echo -e '[INFO] Setting up light...'
    sudo usermod -a -G video "$USER"
    sudo chmod +s /usr/bin/light
}

setup_light