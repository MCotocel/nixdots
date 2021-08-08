{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  programs.ncmpcpp.enable      = true;

  home.username = "matei";
  home.homeDirectory = "/home/matei";

  home.stateVersion = "21.11";

  home.file = {
    # General
    ".Xresources".source                 = ../../config/xresources;
    ".zshrc".source                      = ../../config/zshrc;
    ".local/share/applications".source   = ../../config/applications;
    ".config/discocss/custom.css".source = ../../config/discocss/custom.css;


    ".config/alacritty".source   = ../../config/alacritty;
    ".config/awesome".source     = ../../config/awesome;
    ".config/bspwm".source       = ../../config/bspwm;
    ".config/cava".source        = ../../config/cava;
    ".config/dunst".source       = ../../config/dunst;
    ".config/eww".source         = ../../config/eww;
    ".config/jgmenu".source      = ../../config/jgmenu;
    ".config/kitty".source       = ../../config/kitty;
    ".config/ncmpcpp".source     = ../../config/ncmpcpp;
    ".config/openbox".source     = ../../config/openbox;
    ".config/picom".source       = ../../config/picom;
    ".config/polybar".source     = ../../config/polybar;
    ".config/qutebrowser".source = ../../config/qutebrowser;
    ".config/rofi".source        = ../../config/rofi;
    ".config/river".source       = ../../config/river;
    ".config/sxhkd".source       = ../../config/sxhkd;
    ".config/wofi".source        = ../../config/wofi;
    ".config/wtf".source         = ../../config/wtf;
    ".config/xmonad".source      = ../../config/xmonad;

    # Ranger
    ".config/ranger/rc.conf".source    = ../../config/ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ../../config/ranger/rifle.conf;
    ".config/ranger/scope.sh".source   = ../../config/ranger/scope.sh;

    # Emacs
    ".config/emacs/doom-quiet-dark-theme.el".source  = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/doom-quiet-light-theme.el".source = ../../config/emacs/doom-quiet-light-theme.el;
    ".config/emacs/emacs.org".source                 = ../../config/emacs/emacs.org;
    ".config/emacs/init.el".source                   = ../../config/emacs/init.el;
    ".config/emacs/style.css".source                 = ../../config/emacs/style.css;
    ".config/emacs/etc/private.el".source            = ../../config/emacs/private.el;
    ".config/emacs/pfp_rounded_small.png".source     = ../../config/emacs/pfp_rounded_small.png;

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source   = ../../config/nvim/colors;

    # MPD
    #".config/mpd/mpd.conf".source         = ../../config/mpd/mpd.conf;

    # User binaries
    ".bin".source     = ../../config/bin;
  };
}
