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
  home.packages = with pkgs; [
    i3status
    arandr
    dex
    dunst
    feh
    i3lock
    i3status
    picom
    xautolock
    volumeicon
    brightnessctl
    bluez
    xfce.xfce4-power-manager
    polkit_gnome
    networkmanagerapplet
    lxappearance
    clipit
    flameshot
    pavucontrol
    dunst
    picom
  ];

  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  home.file.".local/share/xsessions/i3.desktop".source = ./i3.desktop;
}
