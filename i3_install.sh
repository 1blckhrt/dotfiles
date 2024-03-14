#!/bin/bash

if [ ! -d "/home/blckhrt" ]; then
    read -p "Home directory for user blckhrt not found, enter username: " WHOAMI
else
    WHOAMI="blckhrt"
fi

USERDIR=/home/$WHOAMI

check_system() {
    # Check if the script has been run as root
    if [ "$(id -u)" -eq 0 ]; then
        echo -e "[INFO] Script has been run as root. Continuing..."
    else
        echo -e "[ERROR] Script has not been run as root. Please relaunch using sudo."
        exit 1
    fi

    # Check if the package manager is apt
    if [ -x /usr/bin/apt ]; then
        echo -e "[INFO] Apt package manager is installed. Continuing..."
    else
        echo -e "[ERROR] Apt package manager is NOT installed. Please relaunch on a system with the Apt package manager."
        exit 1
    fi

    # Check if the dotfiles repo exists in ~/dotfiles
    if [ -d ~/dotfiles ]; then
        echo -e "[INFO] Dotfiles repo exists in ~/dotfiles. Continuing..."
    else
        echo -e "[WARNING] Dotfiles repo does not exist in ~/dotfiles. Cloning the repo..."
        git clone https://github.com/1blckhrt/dotfiles.git ~/dotfiles || {
            echo -e "[ERROR] Failed to clone dotfiles repo. Exiting..."
            exit 1
        }
    fi
}
export -f check_system

install_i3() {
    echo -e '[INFO] Installing i3...'
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
    apt install ./keyring.deb
    echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
    apt update
    apt install i3
}
export -f install_i3

install_pkg() {
    echo -e '[INFO] Updating and upgrading system...'
    apt update && apt upgrade -y
    echo -e '[INFO] Installing packages...'
    apt install -y \
        autoconf \
        gcc \
        make \
        pkg-config \ 
        libpam0g-dev \ 
        libcairo2-dev \
        libfontconfig1-dev \
        libxcb-composite0-dev \
        libev-dev \
        libx11-xcb-dev \
        libxcb-xkb-dev \
        libxcb-xinerama0-dev \
        libxcb-randr0-dev \
        libxcb-image0-dev \
        libxcb-util0-dev \
        libxcb-xrm-dev \
        libxkbcommon-dev \
        libxkbcommon-x11-dev libjpeg-dev
        i3status \
        i3blocks \
        dmenu \
        rofi \
        feh \
        picom \
        polybar \
        btop \
        dunst \
        flameshot \
        python3 \
        xrandr \
        materia-gtk-theme \
        papirus-icon-theme \
        lxappearance \
        fonts-font-awesome \
        fonts-droid-fallback || {
        echo -e "[ERROR] Failed to install packages. Exiting..."
        exit 1
    }
    echo -e "[INFO] Finished installing packages. Continuing..."
}
export -f install_pkg

sudo() {
	check_system
	install_pkg
    install_i3
}

non_sudo() {
    chmod -R +x ~/dotfiles/sub-i3-install-scripts/
    bash ~/dotfiles/sub-i3-install-scripts/move_i3_files.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_i3_scripts.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_i3blocks.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_i3_status.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_dunst.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_picom.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_polybar.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_rofi.sh
    bash ~/dotfiles/sub-i3-install-scripts/move_wallpaper.sh
}
export -f non_sudo

su "$SUDO_USER" -c "non_sudo"