{
  description = "Home Manager + System Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    system-manager,
    nix-system-graphics,
    ...
  }: {
    systemConfigs = {
      laptop = system-manager.lib.makeSystemConfig {
        modules = [
          ./hosts/laptop/system.nix
          nix-system-graphics.systemModules.default
        ];
      };
    };

    homeConfigurations = {
      "blckhrt@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
       extraSpecialArgs = {
  inputs = {
    inherit self nixpkgs home-manager system-manager nixvim nix-system-graphics;
  };
};
        modules = [
          ./hosts/laptop/home.nix
          {home.packages = [system-manager.packages.x86_64-linux.default];}
        ];
      };
    };
  };
}
