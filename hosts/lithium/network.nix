{ config, pkgs, ... }:

{
  # Network settings.
  networking = {
    hostName = "lithium"; # Hostname
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = false; # Stay out, hackers
    networkmanager.dns = "none";
    nameservers = [ "192.168.168.111" "1.1.1.1" ];
    interfaces.wlp0s20f3.ipv4.addresses = [ {
      address = "192.168.168.110";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.168.110";
    extraHosts = ''
      192.168.168.110 lithium
      192.168.168.111 sodium
      192.168.168.112 potassium
    '';
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
