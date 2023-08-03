# You probably shouldn't be using my configuration as a guideline.
# Sure, it works (mostly), but the code is horrible.
# I'll also have unnecessary information in comments.
# Why? I'll pretty much journal why I added something, instead of just saying what it is.

{
  description =
    "I have no idea what the hell I'm doing"; # It's true! I have a better feel for Nix and NixOS than before though.

  inputs = {
    f2k.url =
      "github:fortuneteller2k/nixpkgs-f2k"; # F2K's packages. I used to use this for AwesomeWM Git, but I've since moved on to Hyprland
    home-manager.url =
      "github:nix-community/home-manager"; # Managing my dotfiles, mostly. I'm the only user, so I don't use it to install packages, instead using the default, system-wide method
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Living on the edge. Sometimes things break, but it's worth it for newer packages most of the time
    nur.url =
      "github:nix-community/nur"; # Nix User Repository for packages not in nixpkgs
    nixos-generators.url =
      "github:nix-community/nixos-generators"; # For creating ISOs when I need to reinstall NixOS on a machine
    kmonad.url =
      "github:kmonad/kmonad?dir=nix"; # I have a 60% now (technically a 61%), so I need to bind some keys with layers
    emacs.url = "github:nix-community/emacs-overlay/master"; # The bleeding edge of Emacs
  };

  outputs = { self, nixpkgs, home-manager, nur, f2k, nixos-generators, emacs, kmonad, ... }: {

      nixosConfigurations = {

        lithium =
          nixpkgs.lib.nixosSystem { # This is my main system, an X1 Carbon Gen 8. I've switched to this from my older Lenovo Legion 5
            system = "x86_64-linux"; # What did you expect?
            modules = [
              {
                nixpkgs.overlays = [
                  (self: super: {
                    ncmpcpp = super.ncmpcpp.override {
                      visualizerSupport = true;
                    }; # Visualiser support for NCMPCPP (it looks cool). At the moment I'm using Spotify, but if I ever get around to doing a NAS build, I'm switching over to NCMPCPP and local FLAC files
                  })
                  f2k.overlays.default
                  (import self.inputs.emacs)
                  (self: super: {
                    emacs-unstable = super.emacs-unstable.override {
                      withXwidgets = true; # Mostly for the browser
                      withGTK3 = true; # Makes the menus look better
                    };
                  })
                ];
              }
              home-manager.nixosModules.home-manager
              { home-manager.users.matei = import ./hosts/lithium/home.nix; }
              kmonad.nixosModules.default # For remapping keyboard keys
              ./hosts/lithium/configuration.nix
            ];
          };

        sodium =
          nixpkgs.lib.nixosSystem { # This is my system for gaming, a Lenovo Legion 5. I used to use this before the X1 Carbon as my main system, and I'm not quite sure if I should sell it or keep it
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = [
                  f2k.overlays.default
                  (import self.inputs.emacs)
                  (self: super: {
                    emacs-unstable = super.emacs-unstable.override {
                      withXwidgets = true;
                      withGTK3 = true;
                    };
                  })
                ];
              }
              home-manager.nixosModules.home-manager
              { home-manager.users.matei = import ./hosts/sodium/home.nix; }
              kmonad.nixosModules.default
              ./hosts/sodium/configuration.nix
            ];
          };

      };
    };
}
