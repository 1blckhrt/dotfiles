# zsh stuff
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="xiong-chiamiov-plus"

plugins=( 
    git
)

source $ZSH/oh-my-zsh.sh

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# nvim to path
export PATH="$PATH:/opt/nvim-linux64/bin"

# node to path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aliases
source "$HOME/.zsh_aliases"

