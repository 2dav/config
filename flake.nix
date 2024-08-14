{
  description = "Ephemeral NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, impermanence }@inputs: 
    let 
      inherit (self) outputs;
    in rec {
      nixosConfigurations = {
        tower = nixpkgs.lib.nixosSystem { 
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/default.nix
            ./hosts/tower.nix
            ./hosts/persist.nix
            impermanence.nixosModules.impermanence
          ];
        };
      };
    };
}
