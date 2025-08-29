{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
  };

  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
