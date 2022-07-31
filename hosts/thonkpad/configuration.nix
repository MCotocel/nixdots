{ config, pkgs, ... }:

{

  imports = [ # Bringing everything in
    ./code.nix
    ./desktop.nix
    ./gaming.nix
    ./grafana.nix
    ./hardware.nix
    ./network.nix
    ./services.nix
    ./sound.nix
    ../shared.nix
    #../../modules/kmonad/nix/nixos-module.nix
  ];

  #services.kmonad = {
  #  enable = true;
  #  configfiles = [ ~/.config/kmonad/kmonad.kbd ];
	#  package = import ../../derivations/kmonad.nix;
  #};

  users.groups = { uinput = {}; };

  users.users.matei = { # That's me
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "input" "uinput" ];
    shell = pkgs.zsh;
    initialPassword = "1234"; # I always change this don't worry
  };

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ]; # For my Raspberry Pi
    cleanTmpDir = true;
  };

  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ]; # Easier on the eyes

  nixpkgs.config.permittedInsecurePackages = [ # Sorry
     "ffmpeg-3.4.8"
     "libav-12.3"
     "googleearth-pro-7.3.4.8248"
  ];

  nixpkgs.config.allowBroken = true; # I mess around with NixOS a lot

  system.stateVersion = "22.11"; # Current system version
}
