{ config, pkgs, ... }:

{
  networking.firewall.enable = false;
  networking.hostName = "sodium";
  networking.networkmanager.enable = true;
}
