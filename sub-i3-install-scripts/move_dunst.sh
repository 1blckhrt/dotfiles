#!/bin/bash

move_dunst_files() {
    echo -e '[INFO] Moving dunst files...'
    ln -sfb ~/dotfiles/config-files/dunst/dunstrc ~/.config/dunst/dunstrc
}

move_dunst_files