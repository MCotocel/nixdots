{
  description = "I have no idea what the hell I'm doing";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url          = "github:nix-community/nur";
    agenix.url       = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, home-manager, nur, agenix }: {

    nixosConfigurations = {

      thebe = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	      home-manager.nixosModules.home-manager {
            home-manager.users.matei = import ./hosts/thebe/home.nix;
	      }
	      { nixpkgs.overlays = [ nur.overlay ]; }
	      ./hosts/thebe/configuration.nix
        ];
      };

      ganymede = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.age
	      home-manager.nixosModules.home-manager {
            home-manager.users.matei = import ./hosts/ganymede/home.nix;
	      }
	      { nixpkgs.overlays = [
            nur.overlay
            (import (builtins.fetchTarball {
              url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
            }))
            ]; }
          agenix.nixosModules.age
	      ./hosts/ganymede/configuration.nix
        ];
      };

    };

  };
}
