{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    coreutils
    python3
    mosh
    fzf
    fd
    ripgrep
    bat
    lsd
    zoxide
    btop
    fastfetch
    gh
    gcc
    uv
    alejandra
    direnv
    zip
    unzip
    wallust
  ];

  home.file.".xinitrc" = {
    text = ''
      export DISPLAY=:0
      exec i3
    '';
    executable = true;
  };

  fonts.fontconfig.enable = true;
}
