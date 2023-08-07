{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "sodium"; # Hostname
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = true; # Stay out, hackers
    firewall.allowedTCPPorts = [
      22
      88
      1701
      2342
    ];
    firewall.allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    firewall.allowedUDPPorts = [
      2234
      4445
    ];
  };

  # SSH
  services.openssh.enable = true; # Secure shell
  services.openssh.settings.X11Forwarding = true; # Forwarding X11

  services.avahi = { # For my NAS
    enable = true;
    nssmdns = true;
  };
}
