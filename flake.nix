{
  description = "I have no idea what the hell I'm doing"; # It's true!

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nur.url          = "github:nix-community/nur";
    agenix.url       = "github:ryantm/agenix";
    f2k.url          = "github:fortuneteller2k/nixpkgs-f2k";
    #kmonad           = "file:./derivations/kmonad.nix";
  };

  outputs = { self, nixpkgs, home-manager, nur, agenix, f2k, ... }: {

    nixosConfigurations = let lib = nixpkgs.lib;

    in {

      thonkpad = (lib.makeOverridable lib.nixosSystem) { # It's not a thonkpad, I just can't be bothered to change the name
        system = "x86_64-linux"; # Like most laptops and desktops
        modules = [
          agenix.nixosModules.age # Agenix, will use it later
	        home-manager.nixosModules.home-manager {
              home-manager.users.matei = import ./hosts/thonkpad/home.nix; # Home-manager for managing dotfiles
	        }
	      { nixpkgs.overlays = [
            nur.overlay # Nix User Repository, for user-maintained packages
            (import (builtins.fetchTarball {
              url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz; # Latest Emacs version
            }))
            (self: super: {
              emacsGit = super.emacsGit.override { # Modify Emacs to use Xwidgets
                withXwidgets = true;
                withGTK3 = true;
              };
            })
            f2k.overlays.default # Fortuneteller2k's overlays, mostly for awesome-git
            ]; }
	      ./hosts/thonkpad/configuration.nix # Load main config for thonkpad
        ]; };
    };
  };
}
