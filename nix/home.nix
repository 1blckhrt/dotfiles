{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "blckhrt";
  home.homeDirectory = "/home/blckhrt";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "25.05"; # DO NOT TOUCH
  imports = [
    ./programs/tmux/default.nix
    ./programs/kitty/default.nix
    ./programs/nvim/default.nix
    ./programs/starship/default.nix
    ./programs/ssh/default.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];
  home.packages = with pkgs; [
    fzf
    google-chrome
    fd
    tmux
    ripgrep
    atuin
    starship
    bat
    lsd
    unzip
    zoxide
    btop
    zsh
    fastfetch
    gh
    gcc
    brightnessctl
    wallust
    obsidian
    vesktop
    kitty
    mpd
    pavucontrol
    uv
    vscode
    prismlauncher
    alejandra
    nixfmt
    direnv
    nerd-fonts.adwaita-mono
  ];

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

    gh = {enable = true;};

    fzf = {enable = true;};

    ripgrep = {enable = true;};

    bat = {enable = true;};

    lsd = {enable = true;};

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    btop = {enable = true;};

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        h = "history";
        ff = "fastfetch";
        c = "clear";
        x = "exit";
        tree = "lsd --tree";
        nv = "nvim .";
        reload = "source ~/.zshrc";
      };
      initContent = ''
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

            function cd() {
               				if [[ $# -eq 0 ]]; then
                   				builtin cd ~/blckhrt_home
                 			else
                   				builtin cd "$@"
               				fi
               			}

          hugopost() {
          # Ensure we're in a Hugo site directory
          if [ ! -f "./hugo.toml" ] && [ ! -d "./content" ]; then
            echo "❌ Not in Hugo blog directory (missing config file or content/ folder)."
            return 1
          fi

          read "title?Enter post title: "
          read "categories?Enter categories (comma-separated): "
          read "tags?Enter tags (comma-separated): "

          # Slugify the title
          slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')
          datetime=$(date +"%Y-%m-%dT%H:%M:%S%z")
          dirpath="content/posts/$slug"
          filepath="$dirpath/index.md"

          # Format list input for YAML
          cat_array() {
            echo $1 | sed -E 's/^[[:space:]]+|[[:space:]]+$//g' | tr ',' '\n' | sed 's/^ */"/;s/ *$/"/' | paste -sd, -
          }

          categories_formatted=$(cat_array "$categories")
          tags_formatted=$(cat_array "$tags")

          mkdir -p "$dirpath"

          cat > "$filepath" <<EOF
        ---
        title: "$title"
        date: "$datetime"
        draft: false
        categories: [$categories_formatted]
        tags: [$tags_formatted]
        ---

        EOF

          echo "✅ Created post: $filepath"
          nvim "$filepath"
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

  home.sessionVariables = {EDITOR = "nvim";};
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
