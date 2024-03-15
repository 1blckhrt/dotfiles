#!/bin/bash

setup_light() {
    echo -e '[INFO] Setting up light...'
    usermod -a -G video "$USER"
    chmod +s /usr/bin/light
}

setup_light