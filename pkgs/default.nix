{pkgs, ...}:
with pkgs; {
  helium = callPackage ./helium.nix {};
  commit = callPackage ./commit.nix {};
}
