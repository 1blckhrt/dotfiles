#!/bin/bash

install_zsh() {
    echo -e "\n[INFO] Installing Zsh...\n"
    sudo apt install zsh -y

    echo -e "\n[INFO] Changing default shell to Zsh...\n"
    chsh -s $(which zsh)

    echo -e "\n[INFO] Installing Oh My Zsh...\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo -e "\n[SUCCESS] Zsh has been installed successfully.\n"
}
install_zsh