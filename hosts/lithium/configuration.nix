{ config, pkgs, options, upscayl, ... }:

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
  ];

  users.groups = { uinput = {}; };

  users.users.matei = { # That's me
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "input" "uinput" "docker" ];
    shell = pkgs.zsh;
    initialPassword = "1234"; # I always change this don't worry
  };

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ]; # For my Raspberry Pi
    cleanTmpDir = true;
  };

  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ]; # Easier on the eyes

  nixpkgs.config.permittedInsecurePackages = [ # Sorry
     "googleearth-pro-7.3.4.8248"
  ];

  nixpkgs.config.allowBroken = true; # I mess around with NixOS a lot

  system.stateVersion = "22.11"; # Current system version
}