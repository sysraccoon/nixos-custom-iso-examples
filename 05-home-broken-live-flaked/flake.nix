{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
  in {
    nixosConfigurations = {
      liveImage = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit home-manager; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
