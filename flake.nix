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

      thonkpad = (lib.makeOverridable lib.nixosSystem) {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.age
	        home-manager.nixosModules.home-manager {
            home-manager.users.matei = import ./hosts/thonkpad/home.nix;
	        }
	        { nixpkgs.overlays = [

              nur.overlay

              (import (builtins.fetchTarball {
                url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
              }))
              (self: super: {
                emacsGit = super.emacsGit.override {        
                  withXwidgets = true;
                };
              })

              nixpkgs-f2k.overlay

              ]; }
	        ./hosts/thonkpad/configuration.nix
        ];
      };

      applepie = (lib.makeOverridable lib.nixosSystem) {
        system = "aarch64-linux";
        modules = [
	        ./hosts/applepie/configuration.nix
        ];
      };

    };

  };
}
