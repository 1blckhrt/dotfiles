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

    extraConfig = ''
          # --- Auto-install TPM if missing ---
          if "test ! -d ~/.tmux/plugins/tpm" \
             "run-shell 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'"

          # --- Plugin list ---
          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'tmux-plugins/tmux-resurrect'
          set -g @plugin 'tmux-plugins/tmux-sensible'
          set -g @plugin 'tmux-plugins/tmux-yank'
          set -g @plugin 'tmux-plugins/tmux-continuum'
          set -g @plugin 'alexwforsythe/tmux-which-key'
          set -g @plugin '2kabhishek/tmux2k'

          # --- TPM init ---
          run -b '~/.tmux/plugins/tpm/tpm'

          # --- tmux2k config ---
          set -g @tmux2k-theme 'duo'
          set -g @tmux2k-left-plugins "session git cpu ram"
          set -g @tmux2k-right-plugins "battery network time"

          # Continuum config
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '1'

          # Which-key config
          set -g @which-key-popup-time 0.1
          set -g @which-key-position top
          bind-key Space run-shell "~/.tmux/plugins/tmux-which-key/which-key.sh"

          # General settings
          setw -g mode-keys vi
          bind d detach
          bind * list-clients
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          bind '"' choose-window
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R
          bind S choose-session
      bind-key -r f run-shell "tmux new ~/.local/scripts/tmux-sessionizer"

          # Resurrect settings
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'

          # Status bar position
          set-option -g status-position top
    '';
  };
}
