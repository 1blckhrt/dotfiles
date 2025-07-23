{
  config,
  pkgs,
  lib,
  ...
}: let
  tmuxWhichKey = builtins.fetchGit {
    url = "https://github.com/alexwforsythe/tmux-which-key.git";
    rev = "1f419775caf136a60aac8e3a269b51ad10b51eb6";
  };
in {
  programs.tmux = {
    enable = true;
    prefix = "C-x";
    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      sensible
      yank
      tmux-sessionx
      catppuccin
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
    ];
    extraConfig = ''
               run-shell "${tmuxWhichKey}/plugin.sh.tmux"

                          # Key bindings and settings
                          setw -g mode-keys vi
                          bind d detach
                          bind * list-clients
                          bind | split-window -h -c "#{pane_current_path}"
                          bind - split-window -v -c "#{pane_current_path}"
                          bind r source-file ~/.config/tmux/tmux.conf
                          bind '"' choose-window
                          bind h select-pane -L
                          bind j select-pane -D
                          bind k select-pane -U
                          bind l select-pane -R
                          bind S choose-session

                          # Resurrect settings
                          set -g @resurrect-strategy-vim 'session'
                          set -g @resurrect-strategy-nvim 'session'
                          set -g @resurrect-capture-pane-contents 'on'

                       set -g @which-key-popup-time 0.1
                          set -g @which-key-position bottom

               				bind-key Space run-shell "sh ${tmuxWhichKey}/which-key.sh"

         							set -g @sessionx-bind 'o'
         set -g @sessionx-x-path '~/dotfiles'
         set -g @sessionx-window-height '85%'
         set -g @sessionx-window-width '75%'
         set -g @sessionx-zoxide-mode 'on'
         set -g @sessionx-custom-paths-subdirectories 'false'
         set -g @sessionx-filter-current 'false'
      set-option -g status-position top
    '';
  };
}
