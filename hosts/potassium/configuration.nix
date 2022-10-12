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
  networking.interfaces.wlan0.ipv4.addresses = [ {
    address = "192.168.168.112";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.168.112";


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

