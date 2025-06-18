{ ... }: {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
  };

  programs.tmux.extraConfig = ''
    unbind-key -a
    unbind C-b
    set -g prefix C-x
    setw -g mode-keys vi
    set -g @continuum-restore 'on'
    run '~/.tmux/plugins/tpm/tpm'
  '';
}
