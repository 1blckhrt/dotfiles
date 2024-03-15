#!/bin/bash

wget_discord() {
    if command -v discord &> /dev/null; then
        echo "[INFO] Discord is already installed."
        return
    fi

    else 
        echo '[INFO] Installing Discord...'
        wget -O ~/Downloads/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
        dpkg -i ~/Downloads/discord.deb
        apt-get install -f
        echo "[INFO] Discord has been installed. Continuing..."
    fi
}

wget_discord