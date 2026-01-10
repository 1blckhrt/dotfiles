{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
  ];

  home.file.".zshrc" = {
    text = ''
      source ~/dot/dotfiles/zsh/zsh.zsh
    '';
    executable = true;
  };
}
