#!/bin/bash

install_packages(){
    echo -e "\n[INFO] Installing packages...\n"
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install -y \
        curl \
        wget \
        unzip \
        zsh \
        bat \
        fzf \
        lsd \
    echo -e "\n[SUCCESS] Packages have been installed successfully.\n"

    echo -e "\n[INFO] Changing directory to Downloads...\n"
    cd ~/Downloads

    echo -e "\n[INFO] Downloading packages not available in the default repositories...\n"
    wget -O vesktop.deb https://vencord.dev/download/vesktop/arm64/deb
    wget -O vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
    wget -O appimagelauncher.deb https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb

    echo -e "\n[INFO] Downloading AppImages...\n"
    wget -O nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    wget -O prismlauncher.appimage https://github.com/PrismLauncher/PrismLauncher/releases/download/8.4/PrismLauncher-Linux-x86_64.AppImage

    echo -e "\n[INFO] Installing downloaded packages...\n"
    sudo dpkg -i vesktop.deb
    sudo dpkg -i vscode.deb
    sudo dpkg -i appimagelauncher.deb

    echo -e "\n[INFO] Creating directories for AppImages...\n"
    mkdir ~/Apps
    mv *.appimage ~/Apps

    echo -e "\n[INFO] Making AppImages executable...\n"
    chmod u+x ~/Apps/*.appimage
    
    echo -e "\n[SUCCESS] Packages have been installed successfully.\n"
}
install_packages