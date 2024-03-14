#!/bin/bash

move_wallpaper() {
    echo -e '[INFO] Moving wallpaper...'
    ln -sfb ~/dotfiles/wallpapers/wallpaper.jpg ~/Pictures/Wallpapers/wallpaper.jpg
}

move_wallpaper