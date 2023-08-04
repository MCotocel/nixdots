{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "lithium"; # Hostname
    networkmanager.enable = true; # Enable networkmanager
    #networkmanager.dns = "none";
    #nameservers = [ "127.0.0.1" "::1" ];
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

  #services.dnscrypt-proxy2 = {
  #  enable = true;
  #  settings = {
  #    require_dnssec = true;

  #    sources.public-resolvers = {
  #      urls = [
  #        "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
  #        "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
  #      ];
  #      cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
  #      minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
  #    };
  #  };
  #};

  #systemd.services.dnscrypt-proxy2.serviceConfig = {
  #  StateDirectory = "dnscrypt-proxy";
  #};

}
