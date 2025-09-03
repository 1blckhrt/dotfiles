{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [./tmux-sessionizer.nix ./notes/default.nix];
}
