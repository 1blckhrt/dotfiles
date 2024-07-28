#!/bin/bash

git_setup() {
	echo -e '[INFO] Setting git configurations...'
	git config --global user.name 1blckhrt
	git config --global user.email williams.1691@wright.edu

	read -rp "[PROMPT] Which core editor do you prefer, Vim, Neovim, or Nano (vim/neovim/nano): " editor

	# Convert input to lowercase for case-insensitive comparison
	editor=$(echo -e "$editor" | tr '[:upper:]' '[:lower:]')

	# Check the user's choice and set the core editor accordingly
	if [[ "$editor" == "vim" ]]; then
		git config --global core.editor "vim"
		echo -e '[INFO] Finished setting git configurations. Continuing...'
  elif [[ "$editor" == "neovim" ]]; then
    git config --global core.editor "nvim"
    echo -e '[INFO] Finished setting git configurations. Continuing...'
	elif [[ "$editor" == "nano" ]]; then
		git config --global core.editor "nano"
		echo -e '[INFO] Finished setting git configurations. Continuing...'
  else
		echo -e "[ERROR] Invalid choice. Please enter 'vim', 'neovim', or 'nano'."
		exit 1
	fi
}


git_setup
