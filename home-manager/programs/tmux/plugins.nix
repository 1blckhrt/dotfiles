{pkgs, ...}: {
  programs.tmux.extraConfig = ''
    set -g @plugin 'fcsonline/tmux-thumbs'
    set -g @plugin 'sainnhe/tmux-fzf'
    set -g @plugin 'wfxr/tmux-fzf-url'
    set -g @plugin "arcticicestudio/nord-tmux"
    set -g @plugin 'omerxx/tmux-sessionx'
    set -g @plugin 'omerxx/tmux-floax'
    set -g @plugin 'alexwforsythe/tmux-which-key'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
  '';
}
