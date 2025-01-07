#!/bin/bash

PACKAGES=(
	"curl"
	"wget"
	"fzf"
	"lsd"
	"ripgrep"
	"fastfetch"
	"zsh"
	"bat"
	"btop"
	"git"
	"github-cli"
	"alacritty"
	"waybar"
	"hyprland"
	"hyprpaper"
	"hyprlock"
	"wofi"
	"ghostty"
	"neovim"
	"unzip"
	"thunar"
	)

AUR_PACKAGES=(
	"vesktop-bin"
	"visual-studio-code-bin"
	)

echo -n "[INFO] Updating system and installing official packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm "${PACKAGES[@]}"

if command -v yay &> /dev/null; then
    echo -n "[INFO] Installing AUR packages with yay..."
    yay -S --noconfirm "${AUR_PACKAGES[@]}"
elif command -v paru &> /dev/null; then
    echo -n "[INFO] Installing AUR packages with paru..."
    paru -S --noconfirm "${AUR_PACKAGES[@]}"
else
    echo -n "[WARN] No AUR helper found. Skipping AUR package installation."
fi

echo -n "[SUCCESS] Package install has completed successfully!"

# do stow stuff here
