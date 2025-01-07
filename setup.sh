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
	"zoxide"
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
	"nodejs"
	'npm'
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

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

echo -n "[SUCCESS] Package install has completed successfully!"

echo -n "[INFO] Starting shell configuration"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

npm install -g pnpm

# do stow stuff here

stow nvim
stow .

echo -n "[SUCCESS] System configured. Please reboot!"
