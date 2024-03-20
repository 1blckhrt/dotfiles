#!/bin/bash

install_miniconda() {
    # Check if Miniconda is already installed
    if [ -d "$HOME/miniconda3" ]; then
        echo "[INFO] Miniconda is already installed."
        return
    fi

    read -rp "[PROMPT] Do you want to install Miniconda? (y/n): " choice

    # Convert input to lowercase for case-insensitive comparison
    choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    # Check the user's choice and proceed accordingly
    if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
        echo '[INFO] Installing Miniconda...'
        mkdir -p ~/miniconda3
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
        bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
        rm -rf ~/miniconda3/miniconda.sh
        echo "[INFO] Miniconda has been installed. Continuing..."
    elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
        echo "[INFO] Not installing Miniconda and continuing..."
    else
        echo "[ERROR] Invalid choice. Please enter 'y' or 'n' for yes or no respectively."
        exit 1
    fi
}

install_miniconda
