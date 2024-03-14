#!/bin/bash

move_i3_scripts() {
    echo -e '[INFO] Moving i3 scripts...'
    ln -sfb ~/dotfiles/i3-scripts/battery ~/Documents/Scripts/battery
    ln -sfb ~/dotfiles/i3-scripts/brightness ~/Documents/Scripts/brightness
    ln -sfb ~/dotfiles/i3-scripts/lock ~/Documents/Scripts/lock
    ln -sfb ~/dotfiles/i3-scripts/logout ~/Documents/Scripts/logout
    ln -sfb ~/dotfiles/i3-scripts/monitors ~/Documents/Scripts/monitors
    ln -sfb ~/dotfiles/i3-scripts/reboot ~/Documents/Scripts/reboot
    ln -sfb ~/dotfiles/i3-scripts/rofi_audiomenu ~/Documents/Scripts/rofi_audiomenu
    ln -sfb ~/dotfiles/i3-scripts/rofi_powermenu ~/Documents/Scripts/rofi_powermenu
    ln -sfb ~/dotfiles/i3-scripts/shutdown ~/Documents/Scripts/shutdown
    ln -sfb ~/dotfiles/i3-scripts/spotify.py ~/Documents/Scripts/spotify.py
    ln -sfb ~/dotfiles/i3-scripts/volume ~/Documents/Scripts/volume

    chmod -R +x ~/Documents/Scripts/
}

move_i3_scripts