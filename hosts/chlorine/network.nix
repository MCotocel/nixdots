{ config, pkgs, ... }:

{
  networking.firewall.enable = false;
  networking.hostName = "chlorine";
  networking.networkmanager.enable = true;
}
