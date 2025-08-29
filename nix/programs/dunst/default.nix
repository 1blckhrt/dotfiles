{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  services.dunst = {
    enable = true;
  };

  home.file.".config/dunst/dunstrc".source = ./dunstrc;
}
