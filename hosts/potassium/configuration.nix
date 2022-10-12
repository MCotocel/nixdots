{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./code.nix
      ./services.nix
      ./grafana.nix
#      ./home.nix
      ../shared.nix
    ];

  networking.hostName = "potassium";
  networking.networkmanager.enable = true;

  users.users.matei = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     shell = pkgs.zsh;
     password = "1234";
   };

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "22.11";
}

