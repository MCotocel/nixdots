# You probably shouldn't be using my configuration as a guideline.
# Sure, it works (mostly), but the code is horrible.
# I'll also have unnecessary information in comments.
# Why? I'll pretty much journal why I added something, instead of just saying what it is.

{
    description = "I have no idea what the hell I'm doing"; # It's true! I have a better feel for Nix and NixOS than before though.

    inputs = {
      f2k.url = "github:fortuneteller2k/nixpkgs-f2k"; # F2K's packages. I use this for awesome-git, because Awesome is an awesome window manager
      home-manager.url = "github:nix-community/home-manager"; # Managing my environment
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Living on the edge
      nur.url = "github:nix-community/nur"; # Nix User Repository for packages not in nixpkgs
      nixos-generators.url = "github:nix-community/nixos-generators"; # For creating ISOs when I need to reinstall NixOS on a machine
      brutality.url = "path:./derivations/brutality"; # Doom, modded with one of my favourite mods
      kmonad.url = "github:kmonad/kmonad?dir=nix"; # Some keys on my keyboard don't work anymore, so I need to create layers to use them
    };

    outputs = { self, nixpkgs, home-manager, nur, f2k, nixos-generators, brutality, kmonad, ... }: {

      nixosConfigurations = {

        lithium = nixpkgs.lib.nixosSystem { # This is my main system, a Lenovo Legion 5. I'm thinking of switching to an X1 Carbon because I already have a steam deck for gaming and the battery life on the Legion is dreadful
          system = "x86_64-linux"; # What did you expect?
          modules = [
            {
              nixpkgs.overlays = [
                nur.overlay
                (_: _: { brutality = brutality.packages.x86_64-linux.brutality; }) # Honestly makes Doom a pretty good game that feels modern.
                (self: super: { ncmpcpp = super.ncmpcpp.override { visualizerSupport = true; }; }) # Visualiser support for NCMPCPP (it looks cool)
                f2k.overlays.default
              ];
            }
            home-manager.nixosModules.home-manager
            { home-manager.users.matei = import ./hosts/lithium/home.nix; }
            kmonad.nixosModules.default # Remapping
            ./hosts/lithium/configuration.nix
          ];
        };

      };
    };
}
