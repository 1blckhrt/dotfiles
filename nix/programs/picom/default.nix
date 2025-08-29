{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  services.picom = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.picom;
    home.file.".config/picom.conf".source = ./picom.conf;
  };
}
