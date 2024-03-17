{ config, pkgs, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  imports = [
    (import ../../config/emacs { inherit pkgs; })
    (import ../../config/firefox { inherit config; })
    (import ../../config/gtk { inherit pkgs; })
    ../../config/alacritty
    ../../config/bin
    ../../config/cava
    ../../config/dunst
    ../../config/eww
    ../../config/gtklock
    ../../config/gzdoom
    ../../config/hypr
    ../../config/ncmpcpp
    ../../config/nvim
    ../../config/rofi
    ../../config/zathura
    ../../config/zsh
  ];

  home.file = { # Files and stuff
    "Pictures/Wallpaper".source = ../../config/wallpaper;
    ".local/share/applications".source = ../../config/applications;
    ".config/kmonad/external.kbd".source = ../../config/kmonad/external.kbd;
    ".config/kmonad/internal.kbd".source = ../../config/kmonad/internal.kbd;
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
