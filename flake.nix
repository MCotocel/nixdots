{
  description = "I have no idea what the hell I'm doing";

  inputs = {
    nixpkgs.url                   = "github:nixos/nixpkgs/nixos-unstable";
    darwin-nixpkgs.url            = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    home-manager.url              = "github:nix-community/home-manager";
    nur.url                       = "github:nix-community/nur";
    darwin.url                    = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "darwin-nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nur, darwin, darwin-nixpkgs }: {

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
	      home-manager.nixosModules.home-manager {
            home-manager.users.matei = import ./hosts/ganymede/home.nix;
	      }
	      { nixpkgs.overlays = [ nur.overlay ]; }
	      ./hosts/ganymede/configuration.nix
        ];
      };

      darwinConfiurations."europa" = darwin.lib.darwinSystem {
        modules = [
	      home-manager.nixosModules.home-manager {
            home-manager.users.matei = import ./hosts/europa/home.nix;
	      }
          ./hosts/europa/configuration.nix
        ];
      };

    };

  };
}
