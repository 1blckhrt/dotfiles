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
              setw -g mode-keys vi
              set -g @continuum-restore 'on'

              bind d detach
              bind * list-clients

              bind | split-window -h -c "#{pane_current_path}"
              bind - split-window -v -c "#{pane_current_path}"

              bind r source-file /home/blckhrt/.config/tmux/.tmux.conf
              bind '"' choose-window
              bind h select-pane -L
              bind j select-pane -D
              bind k select-pane -U
              bind l select-pane -R
              bind S choose-session

         		 run-shell ${pkgs.tmuxPlugins.nord}/share/tmux-plugins/nord/nord.tmux
         run-shell ${pkgs.tmuxPlugins.tmux-sessionx}/share/tmux-plugins/tmux-sessionx/sessionx.tmux
         run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
         run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
         run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.tmuxPlugins
      run-shell ${pkgs.tmuxPlugins.tmux-which-key}/share/tmux-plugins/tmux-which-key/which-key.tmux

    '';

    plugins = with pkgs.tmuxPlugins; [
      tmux-fzf
      nord
      tmux-sessionx
      resurrect
      continuum
      tmux-which-key
    ];
  };
}
