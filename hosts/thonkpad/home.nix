{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  home.file = { # Files and stuff
    "Pictures/Wallpaper".source             = ../../config/wallpaper;
    ".bin".source                           = ../../config/bin;
    ".local/share/applications".source      = ../../config/applications;
    ".config/discocss/custom.css".source    = ../../config/discocss/custom.css;
    ".config/qutebrowser/config.py".source  = ../../config/qutebrowser/config.py;
    ".mbsyncrc".source                      = ../../config/mbsyncrc;
    ".Xresources".source                    = ../../config/xresources;
    ".zshrc".source                         = ../../config/zshrc;
    ".gtkrc-2.0".source                     = ../../config/gtk/gtk2;
    ".config/gtk-3.0/settings.ini".source   = ../../config/gtk/gtk3;
    ".config/touchegg/touchegg.conf".source = ../../config/touchegg/touchegg.conf;

    ".config/autorandr/postswitch".source = ../../config/autorandr/postswitch;
    
    ".config/awesome".source      = ../../config/awesome;
    ".config/bspwm".source        = ../../config/bspwm;
    ".config/cava".source         = ../../config/cava;
    ".config/kmonad".source       = ../../config/kmonad;
    ".config/mpd".source          = ../../config/mpd;
    ".config/ncmpcpp".source      = ../../config/ncmpcpp;
    ".config/neofetch".source     = ../../config/neofetch;
    ".config/picom".source        = ../../config/picom;
    ".config/rofi".source         = ../../config/rofi;
    ".config/sxhkd".source        = ../../config/sxhkd;
    ".config/wezterm".source      = ../../config/wezterm;
    ".config/zathura".source      = ../../config/zathura;

    # Ranger
    ".config/ranger/rc.conf".source    = ../../config/ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ../../config/ranger/rifle.conf;
    ".config/ranger/scope.sh".source   = ../../config/ranger/scope.sh;

    # Emacs
    ".config/emacs/init.el".source                  = ../../config/emacs/init.el;
    ".config/emacs/style.css".source                = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.png".source               = ../../config/emacs/banner.png;

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source   = ../../config/nvim/colors;
  };
}
