{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];
  home.file.".tmux.conf".source = ./tmux.conf;
}
