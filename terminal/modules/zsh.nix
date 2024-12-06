{ config, pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "command-not-found"
      ];
    };

    shellAliases = {
      install = "sudo nala install";
      update = "sudo nala update";
      upgrade = "sudo nala upgrade";
      autorm = "sudo nala autoremove";
      h = "history";
      reload = "source ~/.zshrc";
      ff = "fastfetch";
      c = "clear";
      x = "exit";
      cat = "bat";
      ls = "lsd";
      ll = "lsd -l";
      tree = "lsd --tree";
      nv = "nvim .";
    };

    history = {
      size = 10000;
    };

    initExtra = ''
      export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

      source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

      eval "$(zoxide init zsh)"

      . "$HOME/.atuin/bin/env"
      eval "$(atuin init zsh)"

      git_cp() {
        local message="$*"
        
        if [[ -z "$message" ]]; then
          echo "Error: Commit message is required."
          return 1
        fi
        
        git add . || { echo "Failed to add files."; return 1; }
        git commit -am "$message" || { echo "Failed to commit."; return 1; }
        git push || { echo "Failed to push changes."; return 1; }
        
        echo "Changes successfully pushed."
      }

      eval "$(starship init zsh)"
    '';
  };
}