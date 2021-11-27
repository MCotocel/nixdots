{ config, pkgs, ... }:

{

  imports = [
    ./desktop.nix
    ./grafana.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./performance.nix
    ./services.nix
    ./shell.nix
    ./sound.nix
    ../shared.nix
  ];

  users.users.matei = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" ];
    shell = pkgs.zsh;
    initialPassword = "1234";
  };

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    cleanTmpDir = true;
  };

  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ];

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
     "libav-12.3"
     "googleearth-pro-7.3.4.8248"
  ];

  nixpkgs.config.allowBroken = true;

  system.stateVersion = "21.11";
}
