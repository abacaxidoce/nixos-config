{
  description = "Flake Configuration";

  inputs = {
    # NixOS official package source (Stable)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";  # Keep the same version as the system.nix

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11"; # home-manager version = system.nix
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Hostname: "nixos_btw"
    nixosConfigurations.nixos_btw = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        # Home Manager configuration
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.dryyy = import ./home.nix;
          }; # User: "dryyy" 
        }
      ];
    };
  };
}