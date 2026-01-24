{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hooks.url = "github:cachix/git-hooks.nix";
    colors.url = "github:misterio77/nix-colors";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    hooks,
    colors,
    zen-browser,
    ...
  }: let
    lib = nixpkgs.lib {inherit lib;};
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    homeConfigurations = {
      laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/laptop/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };

      pc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/pc/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };
    };

    devShells.${system}.default = let
      check = hooks.lib.${system}.run {
        src = ./.;
        package = pkgs.prek;
        hooks = {
          statix = {
            enable = true;
            settings.ignore = ["/.direnv" "hardware-configuration.nix"];
          };
          convco.enable = true;
          alejandra.enable = true;
        };
      };
    in
      pkgs.mkShell {
        inherit (check) shellHook;
        buildInputs = check.enabledPackages;
      };
    formatter.${system} = pkgs.alejandra;
  };
}
