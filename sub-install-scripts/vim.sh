#!/bin/bash

vim_setup() {
    echo -e '[INFO] Checking if VundleVim repo already exists'
    if [ -d ~/.vim/bundle/Vundle.vim ]; then
        echo -e '[INFO] VundleVim repo already exists. Skipping cloning.'
    else
        echo -e '[INFO] Cloning VundleVim repo'
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || {
            echo -e "[ERROR] Failed to clone VundleVim repo. Exiting..."
            exit 1
        }
    fi

    echo -e '[INFO] Linking vim files'
    ln -sfb ~/dotfiles/config-files/vim/.vimrc ~/.vimrc || {
        echo -e "[ERROR] Failed to link .vimrc file. Exiting..."
        exit 1
    }
    
    echo -e '[INFO] Installing Vim plugins'
    vim -c 'PluginInstall' || {
        echo -e "[ERROR] Failed to install Vim plugins. Exiting..."
        exit 1
    }
}

vim_setup
