#!/bin/bash

ssh_setup() {
	if [ -d ~/.ssh ]; then
		echo -e '[INFO] SSH folder exists, continuing...'
	else 
		echo -e '[INFO] Creating SSH folder...'
		mkdir ~/.ssh
	fi

	echo -e '[INFO] Linking ssh files...'
	ln -sfb ~/dotfiles/config-files/ssh/authorized_keys ~/.ssh/authorized_keys
	ln -sfb ~/dotfiles/config-files/ssh/config ~/.ssh/config
}

ssh_setup