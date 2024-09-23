#!/bin/bash

if [ ! -d "/home/blckhrt" ]; then
	read -p "Home directory for user blckhrt not found, enter username: " WHOAMI
else
	WHOAMI="blckhrt"
fi

USERDIR=/home/$WHOAMI

check_system() {
	# Check if the package manager is apt
	if [ -x /usr/bin/apt ]; then
		echo -e "\n[INFO] Apt package manager is installed. Continuing...\n"
	else
		echo -e "\n[ERROR] Apt package manager is NOT installed. Please relaunch on a system with the Apt package manager.\n"
		exit 1
	fi

	# Check if the dotfiles repo exists in ~/dotfiles
	if [ -d ~/dotfiles ]; then
		echo -e "\n[INFO] Dotfiles repo exists in ~/dotfiles. Continuing...\n"
	else
		echo -e "\n[WARNING] Dotfiles repo does not exist in ~/dotfiles. Cloning the repo...\n"
		git clone https://github.com/1blckhrt/dotfiles.git ~/dotfiles || {
			echo -e "\n[ERROR] Failed to clone dotfiles repo. Exiting...\n"
			exit 1
		}
	fi
}
export -f check_system

install_packages() {
	echo -e "\n[INFO] Updating and upgrading the system...\n"
	sudo apt update -y && sudo apt upgrade -y

	echo -e "\n[INFO] Installing base packages to get started..."
	sudo apt install nala -y

	echo -e "\n[INFO] Installing packages using Nala..."
	sudo nala install -y \
		git \
		bat \
		fzf \
		lsd \
		curl \
		unzip \
		wget \
		gh

	echo -e "\n[INFO] Installing Pacstall..."
	sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install)"

	echo -e "\n[INFO] Installing packages available in the Pacstall repositories..."
	pacstall -I neovim

	echo -e "\n[INFO] Installing Atuin..."
	curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

	echo -e "\n[INFO] Installing Node Version Manager..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

	echo -e "\n[INFO] Sourcing .bashrc to load NVM..."
	source ~/.bashrc

	echo -e "\n[INFO] Installing Node.js..."
	nvm install 20

	echo -e "\n[INFO] Installing Bun..."
	curl -fsSL https://bun.sh/install | bash

	echo -e "\n[INFO] Downloading .deb packages not available in Ubuntu repositories..."
	mkdir -p ~/Downloads/deb_pkg
	wget -O ~/Downloads/deb_pkg/vesktop.deb https://vencord.dev/download/vesktop/arm64/deb

	printf "[INFO] Installing .deb packages..."
    	cd ~/Downloads/deb_pkg
    	sudo nala install ./*.deb -y
    	cd ~

    	printf "[INFO] Installing VS Code..."
   	echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
   	sudo nala install apt-transport-https -y
	sudo nala update
   	sudo nala install code -y
}
export -f install_packages

check_system
install_packages

echo -e "\n[SUCCESS] Your system is ready. It is HIGHLY recommended to reboot before proceeding.\n"
