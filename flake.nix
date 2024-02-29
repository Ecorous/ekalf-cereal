{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, fenix, home-manager }: {
    nixosConfigurations = {
      willow = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./willow/system.nix
          ./common/rust.nix 
          home-manager.nixosModules.home-manager ./willow/home-manager.nix
        ];
      };
      yggdrasil = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./yggdrasil/system.nix
          ./common/rust.nix 
          home-manager.nixosModules.home-manager ./yggdrasil/home-manager.nix
        ];
      };
    };
  };
}
