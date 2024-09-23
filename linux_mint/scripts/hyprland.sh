#!/bin/bash

hyprland_install() {
  sudo nala update -y
  sudo nala upgrade -y
  pacstall -I xcb-util-errors hyprlang hyprcursor-bin hyprland-bin hyprpaper
  wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
  wget http://mirrors.kernel.org/ubuntu/pool/universe/libz/libzip/libzip5_1.5.1-0ubuntu1_amd64.deb
  sudo nala install ./libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
  sudo nala install ./libzip5_1.5.1-0ubuntu1_amd64.deb
  sudo nala install libtomlplusplus-dev
}
hyprland_install
