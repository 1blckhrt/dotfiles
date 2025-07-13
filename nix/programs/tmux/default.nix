{
  config,
  pkgs,
  lib,
  ...
}: {
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
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60'
        '';
      }
    ];

    extraConfig = ''
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

      # Theme configuration (manual nord-like theme)
      set -g status-bg "#2E3440"
      set -g status-fg "#D8DEE9"
      set -g window-status-current-bg "#81A1C1"
      set -g window-status-current-fg "#2E3440"
      set -g pane-border-fg "#4C566A"
      set -g pane-active-border-fg "#81A1C1"
      set -g message-bg "#81A1C1"
      set -g message-fg "#2E3440"

      # Status bar configuration
      set -g status-left-length 40
      set -g status-right-length 80
      set -g status-left "#[fg=#2E3440,bg=#81A1C1,bold] #S #[fg=#81A1C1,bg=#2E3440,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#4C566A,bg=#2E3440,nobold,nounderscore,noitalics]#[fg=#D8DEE9,bg=#4C566A] %Y-%m-%d  %H:%M #[fg=#81A1C1,bg=#4C566A,nobold,nounderscore,noitalics]#[fg=#2E3440,bg=#81A1C1,bold] #h "

      # Window status format
      set -g window-status-format "#[fg=#2E3440,bg=#4C566A,nobold,nounderscore,noitalics]#[default] #I  #W #[fg=#4C566A,bg=#2E3440,nobold,nounderscore,noitalics]"
      set -g window-status-current-format "#[fg=#2E3440,bg=#81A1C1,nobold,nounderscore,noitalics]#[fg=#2E3440,bg=#81A1C1,bold] #I  #W #[fg=#81A1C1,bg=#2E3440,nobold,nounderscore,noitalics]"

      # Custom which-key menu
      bind-key Space display-menu -T "tmux keybindings" \
        "Sessions" s "choose-session" \
        "Windows" w "choose-window" \
        "" \
        "Split horizontal" "|" "split-window -h -c '#{pane_current_path}'" \
        "Split vertical" "-" "split-window -v -c '#{pane_current_path}'" \
        "" \
        "Pane left" h "select-pane -L" \
        "Pane down" j "select-pane -D" \
        "Pane up" k "select-pane -U" \
        "Pane right" l "select-pane -R" \
        "" \
        "Detach" d detach \
        "List clients" "*" list-clients \
        "Reload config" r "source-file ~/.config/tmux/tmux.conf" \
        "" \
        "Save session (Resurrect)" "C-s" "run-shell '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh'" \
        "Restore session (Resurrect)" "C-r" "run-shell '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh'" \
        "Show all keys" "?" list-keys

      # Resurrect settings
      set -g @resurrect-strategy-vim 'session'
      set -g @resurrect-strategy-nvim 'session'
      set -g @resurrect-capture-pane-contents 'on'
    '';
  };
}
