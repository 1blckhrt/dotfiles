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

install_main_packages() {
	echo -e '[INFO] Updating and upgrading system...'
	apt update && apt upgrade -y
	echo -e '[INFO] Installing packages...'
	apt install -y \
		nano \
  		unzip \
		wget || {
		echo -e "[ERROR] Failed to install packages. Exiting..."
		exit 1
	}
	echo -e "[INFO] Finished installing packages. Continuing..."
}
export -f install_main_packages

sudo_functions() {
	check_system
	install_main_packages
}

non_sudo() {
	chmod -R +x ~/dotfiles/ubuntu/sub-install-scripts/
	bash ~/dotfiles/ubuntu/sub-install-scripts/git.sh
	bash ~/dotfiles/ubuntu/sub-install-scripts/home.sh
	bash ~/dotfiles/ubuntu/sub-install-scripts/nvim.sh
}
export -f non_sudo

sudo_functions
su "$SUDO_USER" -c "non_sudo"
echo -e "[SUCCESS] Your system is now setup!"
