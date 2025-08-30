{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  home.username = "blckhrt";
  home.homeDirectory = "/home/blckhrt";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  home.stateVersion = "25.05"; # DO NOT TOUCH

  nixGL = {
    packages = nixGL.packages;
    defaultWrapper = "mesa";
  };

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../programs/i3/default.nix
    ../programs/misc/default.nix
    ../programs/nvim/default.nix
    ../programs/starship/default.nix
    ../programs/ssh/default.nix
    ../programs/alacritty/default.nix
    ../programs/rofi/default.nix
    ../programs/dunst/default.nix
    ../programs/tmux/default.nix
  ];

  home.packages = with pkgs; [
    coreutils
    python3
    mosh
    fzf
    fd
    ripgrep
    atuin
    starship
    bat
    lsd
    zoxide
    btop
    zsh
    fastfetch
    gh
    gcc
    uv
    alejandra
    direnv
    flameshot
    zip
    unzip
    pavucontrol
    playerctl
    nerd-fonts.jetbrains-mono
    (config.lib.nixGL.wrap alacritty)
  ];

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';

  programs = {
    git = {
      enable = true;
      userName = "1blckhrt";
      userEmail = "williams.1691@wright.edu";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "!gh auth git-credential";
      };
      aliases = {
        st = "status";
        pl = "pull";
      };
    };

    gh.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    bat.enable = true;
    lsd.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    btop.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        oo = "cd $HOME/Documents/Notes/";
        h = "history";
        ff = "fastfetch";
        c = "clear";
        x = "exit";
        cat = "bat -pp";
        tree = "lsd --tree";
        nv = "nvim .";
        reload = "source ~/.zshrc";
        mkdir = "mkdir -p";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
      };
      initContent = ''
        bindkey -s '^f' "$HOME/bin/tmux-sessionizer\n"

        # fnm
        FNM_PATH="$HOME/.local/share/fnm"
        if [ -d "$FNM_PATH" ]; then
          export PATH="$FNM_PATH:$PATH"
          eval "$(fnm env)"
        fi

        export TERM=xterm-256color
        eval "$(direnv hook zsh)"

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

        tmux-session() {
          if [ -z "$1" ]; then
          echo "Usage: tmux-session <session-name>"
            return 1
          fi
          tmux new-session -d -s "$1"
          tmux attach -t "$1"
        }
      '';
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        auto_sync = true;
        sync_frequency = "10m";
      };
    };
  };

  home.file."bin/new-note" = {
    text = ''
          #!/bin/bash

          NOTES_DIR="/home/blckhrt/Documents/Notes/Zettelkasten/Inbox"
          mkdir -p "''${NOTES_DIR}"

          # Use only timestamp for filename
          DATE=$(date "+%Y%m%d-%H%M%S")
          FILE="''${NOTES_DIR}/''${DATE}.md"

          if [ ! -f "''${FILE}" ]; then
            cat > "''${FILE}" <<'EOF'
      ---
      tags:
      hubs: put hub here
      ---

      Start writing your note here
      EOF
          fi

          nvim "''${FILE}"
    '';
    executable = true;
  };

  home.file."bin/note-commit" = {
    text = ''
        #!/bin/zsh

        # Get current date/time and short hostname
        DATE=$(date "+%Y%m%d-%H%M%S")
        HOST=$(hostname -s)

        # Commit message
        COMMIT_MSG="vault backup: ''${DATE} - ''${HOST}"

        # Change into vault directory
        VAULT_DIR="/home/blckhrt/Documents/Notes"
        cd "''${VAULT_DIR}" || exit 1

        # Sync first
        git pull --rebase

        # Stage, commit, and push
        git add -A
        git commit -m "''${COMMIT_MSG}"
        git push

        # Show status summary
        git status -sb
      echo "Backup complete: ''${COMMIT_MSG}"
    '';
    executable = true;
  };

  home.file."bin/tmux-sessionizer" = {
    text = ''
      #!/usr/bin/env bash

      if [[ $# -eq 1 ]]; then
        selected=$1
      else
        selected=$(find ~/Documents/dev ~/dev/ ~/Documents/ -mindepth 1 -maxdepth 1 -type d | fzf)
      fi

      if [[ -z $selected ]]; then
        exit 0
      fi

      selected_name=$(basename "$selected" | tr . _)
      tmux_running=$(pgrep tmux)

      if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
      fi

      if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
      fi

      if [[ -z $TMUX ]]; then
        tmux attach -t $selected_name
      else
        tmux switch-client -t $selected_name
      fi
    '';
    executable = true;
  };

  home.file.".xinitrc" = {
    text = ''
      export DISPLAY=:0
      exec i3
    '';
    executable = true;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
