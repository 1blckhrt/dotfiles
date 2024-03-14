#!/bin/bash

move_rofi_files() {
    echo -e '[INFO] Moving rofi files...'
    ln -sfb ~/dotfiles/config-files/rofi/config.rasi ~/.config/rofi/config.rasi
}

move_rofi_files