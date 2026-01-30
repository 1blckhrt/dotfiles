{pkgs, ...}: let
  myPkgs = import ../../../pkgs/default.nix {inherit pkgs;};
in {
  home.packages = [
    myPkgs.helium
  ];
}
