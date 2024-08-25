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
		echo -e "\n[INFO] Script has been run as root. Continuing..."\n
	else
		echo -e "\n[ERROR] Script has not been run as root. Please relaunch using sudo.\n"
		exit 1
	fi

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

echo -e "\n[SUCCESS] Your system is ready. It is HIGHLY recommended to reboot before proceeding.\n"