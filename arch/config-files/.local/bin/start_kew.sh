#!/usr/bin/env zsh

# mount samba share
sudo mount.cifs //192.168.4.163/music ~/Music -o username=blckhrt

# add kew path
kew path = "~/Music"

# start kew within dir
kew all
