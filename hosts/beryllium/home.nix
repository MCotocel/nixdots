{ config, pkgs, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  home.file = { # Files and stuff
    ".config/kmonad/external.kbd".source = ../../config/kmonad/external.kbd;
  };

  # OBS
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
        obs-tuna
      ];
  };
}
