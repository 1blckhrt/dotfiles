{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.username = "blckhrt";
  home.homeDirectory = "/home/blckhrt";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  home.stateVersion = "25.05"; # DO NOT TOUCH

  #nixGL = {
  #  packages = nixGL.packages;
  #  defaultWrapper = "mesa";
  #};

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ../../programs/alacritty/default.nix
    ../../programs/atuin/default.nix
    ../../programs/bin/default.nix
    ../../programs/git/default.nix
    ../../programs/hyprland/default.nix
    ../../programs/misc/default.nix
    ../../programs/nvim/default.nix
    ../../programs/ssh/default.nix
    ../../programs/starship/default.nix
    ../../programs/tmux/default.nix
    ../../programs/zoxide/default.nix
    ../../programs/zsh/default.nix

    ./services/trayscale/default.nix
  ];

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
  '';

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
