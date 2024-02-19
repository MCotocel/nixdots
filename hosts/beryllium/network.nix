{ config, pkgs, lib, ... }:

{
  # Network settings.
  networking = {
    hostName = "beryllium"; # Hostname
    networking.networkmanager.enable = true;
  };
}
