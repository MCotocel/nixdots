{ config, pkgs, kmonad, ... }:

{

  services.syncthing = { # Syncing files
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
    guiAddress = "0.0.0.0:8384";
  };
}
