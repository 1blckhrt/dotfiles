#!/bin/bash

move_i3status() {
    echo -e '[INFO] Moving i3status files...'
    ln -sfb ~/dotfiles/config-files/i3status/i3status.conf ~/.config/i3status/i3status.conf
}

move_i3status