move_picom_files() {
    echo -e '[INFO] Moving picom files...'
    ln -sfb ~/dotfiles/config-files/picom/picom.conf ~/.config/picom.conf
}

move_picom_files