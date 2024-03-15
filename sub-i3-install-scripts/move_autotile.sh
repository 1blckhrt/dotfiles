#!/bin/bash

move_autotile_files() {
    echo -e '[INFO] Moving autotile script...'
    ln -sfb ~/dotfiles/config-files/i3/autotile ~/.config/i3/autotile
}

move_autotile_files