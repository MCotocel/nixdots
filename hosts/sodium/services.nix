{ config, pkgs, kmonad, ... }:

{

  services.syncthing = { # Syncing files
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
  };

  services.transmission.enable = true;
  services.transmission.openFirewall = true;
}
