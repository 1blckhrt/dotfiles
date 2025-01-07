{ config, pkgs, ... }:

{
  home.username = "blckhrt";
  home.homeDirectory = "/home/blckhrt";

  home.stateVersion = "24.05"; # DO NOT CHANGE

  home.packages = [
    pkgs.hello
    pkgs.curl
    pkgs.wget
    pkgs.zoxide
    pkgs.fzf
    pkgs.lsd
    pkgs.ripgrep
    pkgs.fastfetch
    pkgs.zsh
    pkgs.bat
    pkgs.starship
    pkgs.atuin
    pkgs.zoxide
    pkgs.btop
    pkgs.neovim
    pkgs.git
    pkgs.gh
    pkgs.nixfmt
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}