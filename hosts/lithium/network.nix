{ config, pkgs, lib, ... }:

{
  # Network settings.
  networking = {
    hostName = "lithium"; # Hostname
    networkmanager.enable = true; # Enable networkmanager
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      enable = true;
      settings = {
        Settings = {
          AutoConnect = true;
        };
      };
    };
    firewall.enable = true; # Stay out, hackers
    firewall.allowedTCPPorts = [
      22
      88
      1701
      2234
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
    firewall.trustedInterfaces = [ "tailscale0" ];
  };

  # SSH
  services.openssh.enable = false; # Secure shell
  services.openssh.settings.X11Forwarding = true; # Forwarding X11

  services.avahi = { # For my NAS
    enable = true;
    nssmdns4 = true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
