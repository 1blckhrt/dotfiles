#!/usr/bin/env zsh

# check if waybar is running
if ! pgrep -x "waybar" > /dev/null
then
  waybar --config $HOME/.config/waybar/config.jsonc
else
  killall -SIGUSR2 waybar
fi
