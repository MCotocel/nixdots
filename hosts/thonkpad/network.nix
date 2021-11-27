{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "thonkpad"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    wireless.enable = false;
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = true; # Stay out, hackers
    firewall.allowedTCPPorts = [
      22
      88
    ];
  };

  # SSH
  services.openssh.enable = true; # Secure shell
  services.openssh.forwardX11 = true; # Forwarding X11

  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
