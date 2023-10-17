{ config, pkgs, options, ... }:

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

  users.groups = { uinput = {}; plugdev = {}; fuse = {}; realtime = {}; }; # Create some groups

  users.users.matei = { # That's me
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "realtime" "libvirtd" "input" "uinput" "plugdev" "fuse" "dialout" "networkmanager" "wireshark" "docker" ];
    shell = pkgs.zsh; # ZSH > Bash
    initialPassword = "1234"; # I always change this don't worry
  };

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ]; # For building Raspberry Pi images
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org?priority=1"
      "https://fortuneteller2k.cachix.org"
      "https://nix-community.cachix.org"
      "https://nrdxp.cachix.org"
    ];
    trusted-public-keys = [
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
      "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nixpkgs.config.allowBroken = true; # I mess around with NixOS a lot

  system.stateVersion = "22.11"; # Current system version
}
