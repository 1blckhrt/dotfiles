{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;

    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;

    extraConfig = ''
            unbind-key -a
            unbind C-b
            set -g prefix C-x
            setw -g mode-keys vi
            set -g @continuum-restore 'on'

            if "test ! -d ~/.tmux/plugins/tpm" \
             "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
              run '~/.tmux/plugins/tpm/tpm'

            bind d detach
            bind * list-clients

            bind | split-window -h
            bind - split-window -v

            bind r source-file ~/.tmux.conf
            bind '"' choose-window
            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R
            bind S choose-session

            bind \` run-shell "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh}"

      run '~/.tmux/plugins/tpm/tpm'

    '';

    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      nord
      tmux-sessionx
      tmux-which-key
      resurrect
      continuum
    ];
  };
}
