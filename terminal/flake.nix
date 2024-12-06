{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        blckhrt = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./modules/home.nix
            ./modules/zsh.nix
            ./modules/git.nix
          ];
        };
      };
    };
}