{
  description = "I have no idea what the hell I'm doing";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url          = "github:nix-community/nur";
    agenix.url       = "github:ryantm/agenix";
    nixpkgs-f2k.url  = "github:fortuneteller2k/nixpkgs-f2k";
  };

  outputs = { self, nixpkgs, home-manager, nur, agenix, nixpkgs-f2k }: {

    nixosConfigurations = let lib = nixpkgs.lib;
    in {

      thebe = (lib.makeOverridable lib.nixosSystem) {
        system = "x86_64-linux";
        modules = [
	      home-manager.nixosModules.home-manager {
            home-manager.users.matei = import ./hosts/thebe/home.nix;
	      }
	      { nixpkgs.overlays = [ nur.overlay nixpkgs-f2k.overlay ]; }
	      ./hosts/thebe/configuration.nix
        ];
      };

      ganymede = (lib.makeOverridable lib.nixosSystem) {
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

            nixpkgs-f2k.overlay

            ]; }
	      ./hosts/ganymede/configuration.nix
        ];
      };

    };

  };
}
