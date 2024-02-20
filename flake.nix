{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      willow = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./willow/system.nix
          home-manager.nixosModules.home-manager ./willow/home-manager.nix
        ];
      };
      yggdrasil = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./yggdrasil/system.nix
          home-manager.nixosModules.home-manager ./yggdrasil/home-manager.nix
        ];
      };
    };
  };
}
