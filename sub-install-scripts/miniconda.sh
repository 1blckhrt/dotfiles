#!/bin/bash

install_miniconda() {
	read -rp "[PROMPT] Do you want to install Miniconda? (y/n): " choice

	# Convert input to lowercase for case-insensitive comparison
	choice=$(echo -e "$choice" | tr '[:upper:]' '[:lower:]')

	# Check the user's choice and proceed accordingly
	if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
		echo -e '[INFO] Installing Miniconda...'
		mkdir -p ~/miniconda3
		wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
		bash ~/miniconda3/miniconda.sh -b -u -p --no-modify ~/miniconda3
		rm -rf ~/miniconda3/miniconda.sh
		echo -e "[INFO] Miniconda has been installed. Continuing..."
	elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
		echo -e "[INFO] Not installing Miniconda and continuing..."
	else
		echo -e "[ERROR] Invalid choice. Please enter 'y' or 'n' for yes or no respectively."
		exit 1
	fi
}

install_miniconda