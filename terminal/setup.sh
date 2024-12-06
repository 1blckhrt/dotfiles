#!/bin/bash

clear

if [ -x /usr/bin/apt ]; then
	echo -e "[INFO] Apt package manager is installed. Updating and upgrading system..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install nala || {
        echo -e "[ERROR] Failed to install Nala. Please ensure that your internet connection is working and try again."
        exit 1
    }
else
	echo -e "[ERROR] Apt package manager is NOT installed. Skipping update and upgrade with Nala..."
	exit 1
fi

echo -e "[INFO] Installing Nix package manager..."
sh <(curl -L https://nixos.org/nix/install) --daemon

echo -e "[INFO] Reloading shell..."
"$SHELL" -l

echo -e "[INFO] Testing Nix installation..."
if ! nix run nixpkgs#hello; then
    echo -e "[ERROR] Nix installation failed. Please ensure that your internet connection is working and try again."
    exit 1
fi

echo -e "[INFO] Enabling flakes in Nix..."
mkdir -p ~/.config/nix
touch ~/.config/nix/nix.conf
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

echo -e "[INFO] Installing Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

echo -e "[INFO] Reloading shell..."
"$SHELL" -l

echo -e "[INFO] Testing Home Manager installation..."
if ! home-manager --version; then
    echo -e "[ERROR] Home Manager installation failed. Please ensure that your internet connection is working and try again."
    exit 1
fi

if [ -d ~/dotfiles ]; then
    echo -e "[INFO] Dotfiles repo exists in ~/dotfiles. Continuing..."
else
    echo -e "[WARNING] Dotfiles repo does not exist in ~/dotfiles. Cloning the repo..."
    git clone https://github.com/1blckhrt/dotfiles.git ~/dotfiles || {
        echo -e "[ERROR] Failed to clone dotfiles repo. Exiting..."
        exit 1
    }
fi

