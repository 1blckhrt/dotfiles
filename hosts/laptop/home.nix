{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../common/desktop-apps/internet/vesktop.nix
    ../../common/terminal/default.nix
  ];

  modules = {
    discord.enable = true;
  };

  home = {
    username = "blckhrt";
    homeDirectory = "/home/blckhrt";
    stateVersion = "25.11";
    packages = with pkgs; [
      alejandra
      nerd-fonts.geist-mono
      libnotify
    ];
    activation.linkDesktopApplications = {
      after = [
        "writeBoundary"
        "createXdgUserDirectories"
      ];
      before = [];
      data = ''
        rm -rf ${config.xdg.dataHome}/nix-desktop-files/applications
        mkdir -p ${config.xdg.dataHome}/nix-desktop-files/applications
        cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/nix-desktop-files/applications/
      '';
    };
  };

  programs.home-manager.enable = true;
  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    systemDirs.data = ["${config.xdg.dataHome}/nix-desktop-files"];
    mime.enable = true;
  };
}
