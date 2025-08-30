{
  config,
  pkgs,
  lib,
  fetchFromGitHub,
  ...
}: let
  tmux2k = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux2k";
    version = "unstable-latest";
    src = pkgs.fetchFromGitHub {
      owner = "2kabhishek";
      repo = "tmux2k";
      rev = "master";
      sha256 = "0z1k5grh6hgmjk5rrgdsywrly3fafa13k3p3cbnn3r9xj4hsl1w3";
    };
    rtpFilePath = "2k.tmux";
  };

  tmuxWhichKey = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-which-key";
    version = "unstable-latest";
    src = pkgs.fetchFromGitHub {
      owner = "alexwforsythe";
      repo = "tmux-which-key";
      rev = "master";
      sha256 = "1h830h9rz4d5pdr3ymmjjwaxg6sh9vi3fpsn0bh10yy0gaf6xcaz";
    };
    rtpFilePath = "plugin.sh.tmux";
  };
in {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-x";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      continuum
      resurrect
      tmux2k
      {
        plugin = tmuxWhichKey;
        extraConfig = ''
          # enable XDG config
          set -g @tmux-which-key-xdg-enable 1;
        '';
      }
    ];

    extraConfig = ''
         # Prefix
         unbind C-b
         bind C-x send-prefix

         # Escape time + history
         set -sg escape-time 0
         set -g history-limit 1000000

         # Vim-aware pane navigation
         is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
         bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
         bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
         bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
         bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

         # tmux2k config
         set -g @tmux2k-theme 'duo'
      set -g @tmux2k-icons-only true
         set -g @tmux2k-left-plugins "session"
         set -g @tmux2k-right-plugins "battery time"

         # which-key config
         set -g @which-key-popup-time 0.01
         bind-key Space run-shell "${tmuxWhichKey}/which-key.sh"

         # General settings
         setw -g mode-keys vi
         bind d detach
         bind * list-clients
         bind | split-window -h -c "#{pane_current_path}"
         bind - split-window -v -c "#{pane_current_path}"
         bind h select-pane -L
         bind j select-pane -D
         bind k select-pane -U
         bind l select-pane -R

         # Status bar
         set-option -g status-position top

         # Continuum
         set -g @continuum-restore 'on'
         set -g @continuum-save-interval '1'
         set -g @continuum-boot 'on'

         # Resurrect
         set -g @resurrect-save 'S'
         set -g @resurrect-restore 'R'
         set -g @resurrect-save-bash-history 'on'
         set -g @resurrect-save-zsh-history 'on'
         set -g @resurrect-save-shell-history 'on'
         set -g @resurrect-strategy-nvim 'session'
         set -g @resurrect-capture-pane-contents 'on'
    '';
  };

  xdg.configFile."tmux/plugins/tmux-which-key/config.yaml".text = lib.generators.toYAML {} {
    command_alias_start_index = 200;
  };
}
