#!/bin/sh

pkill -x picom

while pgrep -x picom >/dev/null; do
    sleep 0.1
done

/home/blckhrt/.nix-profile/bin/picom --config ~/.config/picom.conf &
