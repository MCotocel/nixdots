{ config, pkgs, kmonad, ... }:

{

  services.syncthing = { # Syncing files
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
    guiAddress = "0.0.0.0:8384";
  };

  services.transmission.enable = true;
  services.transmission.openFirewall = true;
  services.transmission.settings.rpc-bind-address = "0.0.0.0";
  services.transmission.openRPCPort = true;

  services.sonarr = {
    enable = true;
  };

  services.radarr = {
    enable = true;
  };

  services.lidarr = {
    enable = true;
  };
}
