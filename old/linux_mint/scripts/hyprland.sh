#!/bin/bash

hyprland_install() {
  sudo nala update -y
  sudo nala upgrade -y
  pacstall -I xcb-util-errors hyprlang hyprcursor-bin hyprland-bin hyprpaper
  sudo nala install libssl-dev libzip-dev libtomlplusplus-dev
}
hyprland_install
