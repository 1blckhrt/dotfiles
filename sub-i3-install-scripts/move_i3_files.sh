#!/bin/bash

move_i3_files() {
    echo -e '[INFO] Moving i3 files...'
    ln -sfb ~/dotfiles/config-files/i3/bar ~/.config/i3/bar
    ln -sfb ~/dotfiles/config-files/i3/colors ~/.config/i3/colors
    ln -sfb ~/dotfiles/config-files/i3/config ~/.config/i3/config
    ln -sfb ~/dotfiles/config-files/i3/exec_always ~/.config/i3/exec_always
    ln -sfb ~/dotfiles/config-files/i3/fonts ~/.config/i3/fonts
    ln -sfb ~/dotfiles/config-files/i3/gaps ~/.config/i3/gaps
    ln -sfb ~/dotfiles/config-files/i3/keybinds ~/.config/i3/keybinds
    ln -sfb ~/dotfiles/config-files/i3/startup ~/.config/i3/startup
    ln -sfb ~/dotfiles/config-files/i3/workspaces ~/.config/i3/workspaces
}

move_i3_files