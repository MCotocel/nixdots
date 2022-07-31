{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "thonkpad"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    wireless.enable = false; # Using networkmanager instead
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = false; # Stay out, hackers
    firewall.allowedTCPPorts = [
      22
      88
      1701
    ];
  };

  # SSH
  services.openssh.enable = true; # Secure shell
  services.openssh.forwardX11 = true; # Forwarding X11

  services.avahi = { # For my NAS
    enable = true;
    nssmdns = true;
  };
}
