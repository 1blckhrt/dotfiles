#!/bin/bash

install_aws_cli() {
    # Check if AWS CLI is already installed
    if command -v aws &> /dev/null; then
        echo "[INFO] AWS CLI is already installed."
        return
    fi

    read -rp "[PROMPT] Do you want to install AWS CLI? (y/n): " choice

    # Convert input to lowercase for case-insensitive comparison
    choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    # Check the user's choice and proceed accordingly
    if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install || {
            echo "[ERROR] Failed to install AWS CLI. Exiting..."
            exit 1
        }
    elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
        echo "[INFO] Not installing AWS CLI and continuing..."
    else
        echo "[ERROR] Invalid choice. Please enter 'y' or 'n' for yes or no respectively."
        exit 1
    fi
}

install_aws_cli
