#!/bin/bash

home_setup() {
	echo -e '[INFO] Linking zsh files...'
	ln -sfb ~/dotfiles/linux_mint/config-files/zsh/.zshrc ~/.zshrc
    ln -sfb ~/dotfiles/linux_mint/config-files/zsh/.zsh_aliases ~/.zsh_aliases

	echo -e '[INFO] Applying zsh files'
    zsh -c 'source ~/.zshrc'

	echo -e '[INFO] Creating dev folders...'
	cd ~/Documents
	mkdir dev
    cd dev
    mkdir web
    mkdir javascript
    mkdir typescript
    mkdir python

}
home_setup