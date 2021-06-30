{
  description = "A NixOS config";
  inputs = {
    nixpkgs.url      = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    nur.url          = "github:nix-community/NUR";
  };

  outputs = inputs: {
    nixosConfiguration = {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
