install_pkg() {
    echo -e '[INFO] Updating and upgrading system...'
    apt update && apt upgrade -y
    echo -e '[INFO] Installing packages...'
    apt install -y \
        autoconf \
        gcc \
        make \
        pkg-config \ 
        libpam0g-dev \ 
        libcairo2-dev \
        libfontconfig1-dev \
        libxcb-composite0-dev \
        libev-dev \
        libx11-xcb-dev \
        libxcb-xkb-dev \
        libxcb-xinerama0-dev \
        libxcb-randr0-dev \
        libxcb-image0-dev \
        libxcb-util0-dev \
        libxcb-xrm-dev \
        libxkbcommon-dev \
        libxkbcommon-x11-dev libjpeg-dev
        i3status \
        i3blocks \
        dmenu \
        rofi \
        feh \
        picom \
        polybar \
        btop \
        dunst \
        flameshot \
        python3 \
        xrandr \
        materia-gtk-theme \
        papirus-icon-theme \
        lxappearance \
        fonts-font-awesome \
        fonts-droid-fallback || {
        echo -e "[ERROR] Failed to install packages. Exiting..."
        exit 1
    }
    echo -e "[INFO] Finished installing packages. Continuing..."
}

install_pkg