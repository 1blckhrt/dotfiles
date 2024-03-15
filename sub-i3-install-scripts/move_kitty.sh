#!/bin/bash

move_kitty_files() {
    echo -e '[INFO] Moving kitty files...'
    ln -sfb ~/dotfiles/config-files/kitty/kitty.conf ~/.config/kitty/kitty.conf
}

move_kitty_files