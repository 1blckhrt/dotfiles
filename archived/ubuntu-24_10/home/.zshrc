### exporting to path ###
export PATH=$PATH:/snap/bin
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH # standard path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.cargo/bin:$PATH" # This loads Rust's package manager
# pnpm
export PNPM_HOME="/home/blckhrt/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

### zsh options ###
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git)
source "$HOME/.zsh_aliases"

### sourcing dotfiles ###
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

### environment variables ###
export EDITOR=nvim
export VISUAL=$EDITOR

gpush() {
  git add .
  git status

  echo -n "Continue with commit and push? [y/N]: "
  read -r reply
  if [[ "$reply" != "y" && "$reply" != "Y" ]]; then
    echo "Aborted."
    return 1
  fi

  echo -n "Enter commit message: "
  read -r message

  git commit -am "$message"
  git push
}
