{
  description = "I have no idea what the hell I'm doing";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url          = "github:nix-community/nur";
  };

  outputs = { self, nixpkgs, home-manager, nur }: {

    nixosConfigurations = {

      snowstorm = nixpkgs.lib.nixosSystem {
        modules = [
	  ./hosts/snowstorm/configuration.nix
	  ({ ... }: {
	  imports = [
	    home-manager.nixosModules.home-manager
	    { home-manager.users.matei = ./hosts/snowstorm/home.nix; }
	  ];
	  })
        ];
        system = "x86_64-linux";
      };

    };

  };
}
