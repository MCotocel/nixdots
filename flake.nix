# Welcome to NixOS. Have fun...

{
  description = "I have no idea what the hell I'm doing";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs = {
      url = "github:nix-community/emacs-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    nixtheplanet = {
      url = "github:matthewcroughan/nixtheplanet";
    };
  };

  outputs = { self, nixpkgs, home-manager, kmonad, nixos-generators, emacs
    , musnix, nur, nixtheplanet }: {

      nixosConfigurations = {

        lithium = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            kmonad.nixosModules.default
            musnix.nixosModules.musnix
            nixtheplanet.nixosModules.macos-ventura
            nur.nixosModules.nur
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

        fluorine = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/fluorine/configuration.nix
            { home-manager.users.matei = import ./hosts/fluorine/home.nix; }
            { nixpkgs.overlays = [ (import ./overlays/rpi.nix) ]; }
          ];
        };

        chlorine = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/chlorine/configuration.nix
            { home-manager.users.matei = import ./hosts/chlorine/home.nix; }
            { nixpkgs.overlays = [ (import ./overlays/rpi.nix) ]; }
          ];
        };

      };
    };
}
