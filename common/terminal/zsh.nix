{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    initContent = ''
      source ~/dot/dotfiles/zsh/zsh.zsh
    '';
  };
}
