# You probably shouldn't be using my configuration as a guideline.
# Sure, it works (mostly), but the code is horrible.
# I'll also have unnecessary information in comments.
# Why? I'll pretty much journal why I added something, instead of just saying what it is.

{
  description =
    "I have no idea what the hell I'm doing"; # It's true! I have a better feel for Nix and NixOS than before though.

  inputs = {
    #agenix.url =
      #"github:ryantm/agenix"; # Secret management, I should probably set this up sometime. Logins and files I don't really want shared are the only thing stopping a reinstall of NixOS from being fully painless.
    f2k.url =
      "github:fortuneteller2k/nixpkgs-f2k"; # F2K's packages. I use this for awesome-git, and I'm also planning to switch picom to a fork to use the animations.
    home-manager.url =
      "github:nix-community/home-manager"; # Managing my environment
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Living on the edge
    nur.url =
      "github:nix-community/nur"; # Nix User Repository for packages not in nixpkgs
    nixos-generators.url = "github:nix-community/nixos-generators";

    brutality.url = "path:./derivations/brutality"; # Doom, modded
  };

  outputs = { self, nixpkgs, home-manager, nur, f2k, nixos-generators, brutality, ... }@inputs: {

      nixosConfigurations = let lib = nixpkgs.lib;

      in {

        sodium = (lib.makeOverridable lib.nixosSystem) {
          system = "aarch64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.users.matei = import ./hosts/sodium/home.nix; }
            ./hosts/sodium/configuration.nix
          ];
        };

        lithium = (lib.makeOverridable lib.nixosSystem) {
          system = "x86_64-linux"; # What did you expect?
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.users.matei = import ./hosts/lithium/home.nix; }
            {
              nixpkgs.overlays = [
                nur.overlay
                (_: _: {
                  brutality = brutality.packages.x86_64-linux.brutality;
                }) # Honestly makes Doom a pretty good game that feels modern.
                (self: super: {
                  ncmpcpp =
                    super.ncmpcpp.override { visualizerSupport = true; };
                })
                f2k.overlays.default
              ];
            }
            ./hosts/lithium/configuration.nix
          ];
        };

        fluorine = (lib.makeOverridable lib.nixosSystem) {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.users.matei = import ./hosts/fluorine/home.nix; }
            ./hosts/fluorine/configuration.nix
          ];
        };

      };
    };
}
