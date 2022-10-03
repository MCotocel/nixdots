{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "thonkpad"; # Hostname
    wireless.enable = false; # Using networkmanager instead
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = false; # Stay out, hackers
    firewall.allowedTCPPorts = [
      22
      88
      1701
    ];
    firewall.allowedUDPPorts = [
      2234
      4445
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
