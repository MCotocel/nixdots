# Welcome to NixOS. Have fun...

{
  description =
    "I have no idea what the hell I'm doing";
  inputs = {
    nixpkgs.url =
      "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url =
        "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url =
        "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url =
        "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs = {
      url =
        "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixtheplanet = {
      url = "github:matthewcroughan/nixtheplanet";
    };
  };

  outputs = { self, nixpkgs, home-manager, kmonad, nixos-generators, emacs
    , musnix, nur, nixtheplanet }: {

      nixosConfigurations = {

        lithium =
          nixpkgs.lib.nixosSystem { # This is my main system, an X1 Carbon Gen 8. I've switched to this from my older Lenovo Legion 5
            system = "x86_64-linux"; # What did you expect?
            modules = [
              nur.nixosModules.nur
              home-manager.nixosModules.home-manager
              kmonad.nixosModules.default # For remapping keyboard keys
              musnix.nixosModules.musnix
              nixtheplanet.nixosModules.macos-ventura
              ./hosts/lithium/configuration.nix
              {
                home-manager.users.matei.imports =
                  [ nur.hmModules.nur ./hosts/lithium/home.nix ];
              }
              {
                nixpkgs.overlays = [
                  nur.overlay
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
          nixpkgs.lib.nixosSystem { # Also a low-power server, a Raspberry Pi 3. I haven't found a usecase for it yet
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
