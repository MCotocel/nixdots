{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  programs.ncmpcpp.enable      = true;

  programs.git = {
    enable = true;
    userName = "Matei Cotocel";
    userEmail = "mcotocel@outlook.com";
  };

  home.username = "matei";
  home.homeDirectory = "/home/matei";

  home.stateVersion = "21.11";

  home.file = {
    # General
    ".Xresources".source       = ../../config/xresources;
    ".zshrc".source            = ../../config/zshrc;

    ".config/alacritty".source   = ../../config/alacritty;
    #".config/awesome".source     = ../../config/awesome;
    ".config/bspwm".source       = ../../config/bspwm;
    ".config/cava".source        = ../../config/cava;
    ".config/discocss".source    = ../../config/discocss;
    ".config/dunst".source       = ../../config/dunst;
    ".config/eww".source         = ../../config/eww;
    ".config/jgmenu".source      = ../../config/jgmenu;
    ".config/kitty".source       = ../../config/kitty;
    ".config/mpd".source         = ../../config/mpd;
    ".config/ncmpcpp".source     = ../../config/ncmpcpp;
    ".config/openbox".source     = ../../config/openbox;
    ".config/picom".source       = ../../config/picom;
    ".config/polybar".source     = ../../config/polybar;
    ".config/qutebrowser".source = ../../config/qutebrowser;
    ".config/rofi".source        = ../../config/rofi;
    ".config/sxhkd".source       = ../../config/sxhkd;
    ".config/wtf".source         = ../../config/wtf;

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

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source   = ../../config/nvim/colors;
  };
}