# You probably shouldn't be using my configuration as a guideline
# Sure, it works (mostly), but the code is horrible

{
  description = "I have no idea what the hell I'm doing"; # It's true!

  inputs = {
    agenix.url = "github:ryantm/agenix"; # Secret management, I should probably set this up
    f2k.url = "github:fortuneteller2k/nixpkgs-f2k"; # F2K's packages
    home-manager.url = "github:nix-community/home-manager"; # Managing my environment
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Living on the edge
    nur.url = "github:nix-community/nur"; # Nix User Repository for packages not in nixpkgs

    deemix-gui.url = "path:./derivations/deemix-gui"; # Music downloader
    upscayl.url = "path:./derivations/upscayl"; # Image upscaler
  };

  outputs = { self, nixpkgs, home-manager, nur, f2k, upscayl, deemix-gui, ... }@inputs: {

    nixosConfigurations = let lib = nixpkgs.lib;

    in {

      thonkpad = (lib.makeOverridable lib.nixosSystem) {
        system = "x86_64-linux"; # What did you expect?
        modules = [
          home-manager.nixosModules.home-manager
          { home-manager.users.matei = import ./hosts/thonkpad/home.nix; }
          {
            nixpkgs.overlays = [
              (_: _: { upscayl = upscayl.packages.x86_64-linux.upscayl; }) # I spent 90 minutes searching up how to do this, I felt like a genius after finally figuring out. I went up to a friend, slapped his back, and screamed "I'm a fucking genius"
              (_: _: { deemix-gui = deemix-gui.packages.x86_64-linux.deemix-gui; }) # I currently have Spotify premium, but if I'm ever not able to afford it, I've got this. Plus it's nice to own it.
              nur.overlay
              (self: super: {
                ncmpcpp = super.ncmpcpp.override { visualizerSupport = true; };
              })
              f2k.overlays.default
            ];
          }
          ./hosts/thonkpad/configuration.nix
        ];
      };
    };
  };
}
