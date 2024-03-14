#!/bin/bash

move_polybar_files() {
    echo -e '[INFO] Moving polybar files...'
    ln -sfb ~/dotfiles/config-files/polybar/config ~/.config/polybar/config
    ln -sfb ~/dotfiles/config-files/polybar/launch ~/.config/polybar/launch
}

move_polybar_files