{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "thonkpad"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    wireless.enable = false;
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = true;
  };

  # SSH
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
