#!/bin/bash

# System checks
check_system() {
	# Check if the script has been run as root
	if [ "$(id -u)" -eq 0 ]; then
		echo "[SUCCESS] Script has been run as root. Continuing..."
	else
		echo "[ERROR] Script has not been run as root. Please relaunch using sudo."
		exit 1
	fi

	# Check if the package manager is apt
	if [ "$(which apt)" = "/usr/bin/apt" ]; then
		echo "[SUCCESS] Apt package manager is installed. Continuing..."
	else
		echo "[ERROR] Apt package manager is NOT installed. Please relaunch on a system with the Apt package manager."
	fi

	# Check if the dotfiles repo exists in ~/dotfiles
	if [ -d ~/dotfiles ]; then
		echo "[SUCCESS] Dotfiles repo exists in ~/dotfiles. Continuing..."
	else
		echo "[WARNING] Dotfiles repo does not exist in ~/dotfiles. Cloning the repo..."
		git clone https://github.com/1blckhrt/dotfiles.git ~/dotfiles || {
			echo "[ERROR] Failed to clone dotfiles repo. Exiting..."
			exit 1
		}
	fi

}

# Install packages
install_packages() {
	echo '[INFO] Updating and upgrading system...'
	apt update && apt upgrade -y
	echo '[INFO] Installing packages...'
	apt install -y \
		nano \
		vim \
		bind9-dnsutils \
		nmap \
		sl \
		wget
	echo "[SUCCESS] Finished installing packages. Continuing..."
}

# Configuring git
git_setup() {
	echo '[INFO] Setting git configurations'
	git config --global user.name 1blckhrt
	git config --global user.email williams.1691@wright.edu

	# Prompt the user to choose between Vim and Nano
	read -rp "[PROMPT] Which editor do you prefer, Vim or Nano? (v/n): " editor

	# Convert input to lowercase for case-insensitive comparison
	editor=$(echo "$editor" | tr '[:upper:]' '[:lower:]')

	# Check the user's choice and open the selected editor
	if [[ "$editor" == "v" || "$editor" == "vim" ]]; then
		git config --global core.editor "vim"
	elif [[ "$editor" == "n" || "$editor" == "nano" ]]; then
		git config --global core.editor "nano"
	else
		echo "[ERROR] Invalid choice. Please enter 'v' for Vim or 'n' for Nano."
		exit 1
	fi
}

check_system
