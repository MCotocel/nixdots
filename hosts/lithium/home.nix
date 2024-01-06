{ config, pkgs, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  imports = [
    (import ../../config/alacritty { inherit config; })
    (import ../../config/bin { inherit config; })
    (import ../../config/cava { inherit config; })
    (import ../../config/dunst { inherit config; })
    (import ../../config/eww { inherit config; })
    (import ../../config/emacs { inherit config; inherit pkgs; })
    (import ../../config/firefox { inherit config; })
    (import ../../config/gtk { inherit config; inherit pkgs; })
    (import ../../config/gtklock { inherit config; })
    (import ../../config/gzdoom { inherit config; })
    (import ../../config/hypr { inherit config; })
    (import ../../config/ncmpcpp { inherit config; })
    (import ../../config/nvim { inherit config; })
    (import ../../config/rofi { inherit config; inherit pkgs; })
    (import ../../config/zathura { inherit config; })
    (import ../../config/zsh { inherit config; })
  ];

  home.file = { # Files and stuff
    "Pictures/Wallpaper".source = ../../config/wallpaper;
    ".local/share/applications".source = ../../config/applications;
    ".config/kmonad/external.kbd".source = ../../config/kmonad/external.kbd;
    ".config/kmonad/internal.kbd".source = ../../config/kmonad/internal.kbd;
  };
}
