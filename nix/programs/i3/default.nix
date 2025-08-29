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
    extraPackages = with pkgs; [
      i3status
      arandr
      i3lock
      i3status
      picom
      xautolock
      volumeicon
      brightnessctl
      bluez
      bluez-utils
      xfce4-power-manager
      polkit-gnome
      networkmanagerapplet
      lxappearance
      clipit
      flameshot
      pavucontrol
    ];
  };

  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
