{ config, pkgs, ... }:

{
  networking.firewall.enable = false;
  networking.hostName = "fluorine";
  networking.networkmanager.enable = true;
}
