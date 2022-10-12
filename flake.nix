# You probably shouldn't be using my configuration as a guideline.
# Sure, it works (mostly), but the code is horrible.
# I'll also have unnecessary information in comments.
# Why? I'll pretty much journal why I added something, instead of just saying what it is.

{
  description = "I have no idea what the hell I'm doing"; # It's true! I have a better feel for Nix and NixOS than before though.

  inputs = {
    agenix.url = "github:ryantm/agenix"; # Secret management, I should probably set this up sometime. Logins and files I don't really want shared are the only thing stopping a reinstall of NixOS from being fully painless.
    f2k.url = "github:fortuneteller2k/nixpkgs-f2k"; # F2K's packages. I use this for awesome-git, and I'm also planning to switch picom to a fork to use the animations.
    home-manager.url = "github:nix-community/home-manager"; # Managing my environment
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Living on the edge
    nur.url = "github:nix-community/nur"; # Nix User Repository for packages not in nixpkgs
    nixos-generators.url = "github:nix-community/nixos-generators";

    deemix-gui.url = "path:./derivations/deemix-gui"; # Music downloader
    upscayl.url = "path:./derivations/upscayl"; # Image upscaler
    brutality.url = "path:./derivations/brutality"; # Doom, modded
  };

  outputs = { self, nixpkgs, home-manager, nur, f2k, nixos-generators, upscayl, deemix-gui, brutality, ... }@inputs: {

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
              (_: _: { upscayl = upscayl.packages.x86_64-linux.upscayl; }) # I spent 90 minutes searching up how to do this, I felt like a genius after finally figuring out. I went up to a friend, slapped his back, and screamed "I'm a genius"
              (_: _: { deemix-gui = deemix-gui.packages.x86_64-linux.deemix-gui; }) # I currently have Spotify premium, but if I'm ever not able to afford it, I've got this. Plus it's nice to own it.
              (_: _: { brutality = brutality.packages.x86_64-linux.brutality; })
              nur.overlay
              (self: super: {
                ncmpcpp = super.ncmpcpp.override { visualizerSupport = true; };
              })
              f2k.overlays.default
            ];
          }
          ./hosts/lithium/configuration.nix
        ];
      };

      potassium = (lib.makeOverridable lib.nixosSystem) {
        system = "x86_64-linux";
        modules = [
	        home-manager.nixosModules.home-manager
          { home-manager.users.matei = import ./hosts/potassium/home.nix; }
	        ./hosts/potassium/configuration.nix
 	      ];
      };

    };
  };
}
