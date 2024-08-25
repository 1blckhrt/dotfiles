# zsh stuff
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xiong-chiamiov-plus"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh

# nvim to path
export PATH="$PATH:/opt/nvim-linux64/bin"

# node to path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pywal for terminal colors
export PATH="$PATH:$HOME/.local/bin/"

# retrieving color scheme
wal -R

# clearing terminal after pywal output
clear

# aliases
source "$HOME/.zsh_aliases"

