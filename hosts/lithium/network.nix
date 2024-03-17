{ lib, ... }:

{
  # Network settings.
  networking = {
    hostName = "lithium"; # Hostname
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd = {
      enable = true;
      settings = { Settings = { AutoConnect = true; }; };
    };
    firewall = {
      enable = true; # Stay out, hackers
      allowedTCPPorts = [ 22 88 1701 2234 ];
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPorts = [ 2234 4445 ];
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  services = {
    openssh = {
      enable = false; # The most secure shell
      settings.X11Forwarding = true; # Forwarding X11
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
