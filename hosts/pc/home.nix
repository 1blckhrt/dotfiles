{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ../../common/desktop-apps/internet/vesktop.nix
    ../../common/desktop-apps/internet/helium.nix
    ../../common/terminal/default.nix
    ../../common/scripts/default.nix
    ../../common/wm/default.nix
    inputs.colors.homeManagerModules.default
  ];

  modules = {
    discord.enable = true;
  };

  colorScheme = inputs.colors.colorSchemes.nord;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
    nvidia.acceptLicense = true;
  };

  home = {
    username = "blckhrt";
    homeDirectory = "/home/blckhrt";
    stateVersion = "25.11";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
      NIXOS_OZONE_WL = "1";
    };
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
    gpu = {
      nvidia = {
        enable = true;
        sha256 = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
        version = "580.95.05";
      };
    };
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    systemDirs.data = ["${config.xdg.dataHome}/nix-desktop-files"];
    mime.enable = true;
  };
}
