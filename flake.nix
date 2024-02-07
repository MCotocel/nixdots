# You probably shouldn't be using my configuration as a guideline.
# Sure, it works (mostly), but the code is horrible.
# I'll also have unnecessary information in comments.
# Why? I'll pretty much journal why I added something, instead of just saying what it is.

{
  description =
    "I have no idea what the hell I'm doing"; # It's true! I have a better feel for Nix and NixOS than before though.

  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-unstable"; # Living on the edge. Sometimes things break, but it's worth it for newer packages most of the time
    f2k = {
      url =
        "github:fortuneteller2k/nixpkgs-f2k"; # F2K's packages. I used to use this for AwesomeWM Git, but I've since moved on to Hyprland
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url =
        "github:nix-community/home-manager"; # Managing my dotfiles, mostly. I'm the only user, so I don't use it to install packages, instead using the default, system-wide method
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url =
        "github:nix-community/nixos-generators"; # For creating ISOs when I need to reinstall NixOS on a machine
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url =
        "github:kmonad/kmonad?dir=nix"; # I have a 60% now (technically a 61%), so I need to bind some keys with layers
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs = {
      url =
        "github:nix-community/emacs-overlay/master"; # The bleeding edge of Emacs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, kmonad, f2k, nixos-generators, emacs
    , nix-alien, musnix, nur}: {

      nixosConfigurations = {

        lithium =
          nixpkgs.lib.nixosSystem { # This is my main system, an X1 Carbon Gen 8. I've switched to this from my older Lenovo Legion 5
            system = "x86_64-linux"; # What did you expect?
            modules = [
              nur.nixosModules.nur
              home-manager.nixosModules.home-manager
              kmonad.nixosModules.default # For remapping keyboard keys
              musnix.nixosModules.musnix
              ./hosts/lithium/configuration.nix
              {
                home-manager.users.matei.imports = [
                  nur.hmModules.nur
                  ./hosts/lithium/home.nix
                ];
              }
              {
                nixpkgs.overlays = [
                  nur.overlay
                  self.inputs.nix-alien.overlays.default
                  (import self.inputs.emacs)
                  (import ./overlays/emacs-unstable.nix)
                  (import ./overlays/ncmpcpp.nix)
                ];
              }
            ];
          };

        fluorine =
          nixpkgs.lib.nixosSystem { # This is a very low-power server, a Raspberry Pi 4. It's mostly for messing around with at the moment
            system = "aarch64-linux";
            modules = [
              home-manager.nixosModules.home-manager
              { home-manager.users.matei = import ./hosts/fluorine/home.nix; }
              ./hosts/fluorine/configuration.nix
              { nixpkgs.overlays = [ (import ./overlays/rpi.nix) ]; }
            ];
          };

        chlorine =
          nixpkgs.lib.nixosSystem { # Also a low-power server, a Raspberry pi 3. I haven't found a usecase for it yet
            system = "aarch64-linux";
            modules = [
              home-manager.nixosModules.home-manager
              { home-manager.users.matei = import ./hosts/chlorine/home.nix; }
              ./hosts/chlorine/configuration.nix
              { nixpkgs.overlays = [ (import ./overlays/rpi.nix) ]; }
            ];
          };

      };
    };
}
