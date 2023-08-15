{ config, pkgs, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  imports = [
    (import ../../config/dunst { inherit config; })
    (import ../../config/emacs { inherit config; inherit pkgs; })
    (import ../../config/gtk { inherit config; inherit pkgs; })
    (import ../../config/hypr { inherit config; })
    (import ../../config/ncmpcpp { inherit config; })
    (import ../../config/rofi { inherit config; inherit pkgs; })
    (import ../../config/wezterm { inherit config; })
    (import ../../config/nvim { inherit config; })
    (import ../../config/zathura { inherit config; })
  ];

  home.file = { # Files and stuff
    "Pictures/Wallpaper".source = ../../config/wallpaper;
    ".bin".source = ../../config/bin;
    ".local/share/applications".source = ../../config/applications;
    
    ".Xresources".source = ../../config/xresources;
    ".zshrc".source = ../../config/zshrc;

    ".config/gzdoom/gzdoom.ini".source = ../../config/gzdoom/gzdoom.ini;

    ".config/kmonad/external.kbd".source = ../../config/kmonad/external.kbd;
    ".config/kmonad/internal.kbd".source = ../../config/kmonad/internal.kbd;

    ".config/cava".source = ../../config/cava;
    ".config/eww".source = ../../config/eww;

    # Emacs
    ".config/emacs/style.css".source = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.txt".source = ../../config/emacs/banner.txt;

    # GTK
    ".config/gtklock.css".source = ../../config/gtklock.css;
  };
}
