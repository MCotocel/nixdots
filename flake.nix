{
  description = "A work-in-progress flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home.url    = "github:nix-community/home-manager";
    nur.url     = "github:nix-community/nur";
  };

  outputs = { self, nixpkgs, home, nur, ... }: {
    nixosConfigurations.blizzard = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
	./hardware-configuration.nix
      ];
      system = "x86_64-linux";
    };
  };
}
