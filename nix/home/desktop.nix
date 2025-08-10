{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./common.nix ../programs/hyprland/default.nix ../programs/kitty/default.nix];
}
