{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  home.file = { # Files and stuff
    ".bin".source = ../../config/bin;
    ".zshrc".source = ../../config/zshrc;
  };
}
