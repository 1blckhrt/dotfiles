#!/bin/bash

home_config() {
	echo -e '[INFO] Linking .git files...'
	ln -sfb ~/dotfiles/config-files/git/.gitignore_global ~/.gitignore_global
	ln -sfb ~/dotfiles/config-files/git/.gitconfig ~/.gitconfig

	echo -e '[INFO] Linking bash files...'
	ln -sfb ~/dotfiles/config-files/bash/.bashrc ~/.bashrc
	ln -sfb ~/dotfiles/config-files/bash/.bash_aliases ~/.bash_aliases

	echo -e '[INFO] Applying bash files'
	bash -c 'source ~/.bashrc'
	bash -c 'source ~/.bash_aliases'
}

home_config