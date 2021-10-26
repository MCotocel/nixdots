{ config, pkgs, ... }:

{

  imports = [
    ./hardware.nix
    ./desktop.nix
    ./grafana.nix
    ./network.nix
    ./performance.nix
    ./sound.nix
    ./packages.nix
    ./services.nix
    ../shared.nix
  ];

  users.users.matei = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" ];
    shell = pkgs.zsh;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ];

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
     "libav-12.3"
  ];

  system.stateVersion = "21.11";
}
