eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export EDITOR=nvim
export VISUAL=$EDITOR

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
