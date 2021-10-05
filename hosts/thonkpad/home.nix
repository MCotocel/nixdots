{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  programs.ncmpcpp.enable      = true;

  home.username = "matei";
  home.homeDirectory = "/home/matei";

  home.stateVersion = "21.11";

  home.file = {
    "Pictures/Wallpaper".source            = ../../config/wallpaper;
    ".bin".source                          = ../../config/bin;
    ".config/discocss/custom.css".source   = ../../config/discocss/custom.css;
    ".config/qutebrowser/config.py".source = ../../config/qutebrowser/config.py;
    ".mbsyncrc".source                     = ../../config/mbsyncrc;
    ".Xresources".source                   = ../../config/xresources;
    ".zshrc".source                        = ../../config/zshrc;
    ".gtkrc-2.0".source                    = ../../config/gtk/gtk2;
    ".config/gtk-3.0/settings.ini".source  = ../../config/gtk/gtk3;

    ".config/alacritty".source   = ../../config/alacritty;
    ".config/awesome".source     = ../../config/awesome;
    ".config/cava".source        = ../../config/cava;
    ".config/kmonad".source      = ../../config/kmonad;
    ".config/ncmpcpp".source     = ../../config/ncmpcpp;
    ".config/neofetch".source    = ../../config/neofetch;
    ".config/picom".source       = ../../config/picom;
    ".config/rofi".source        = ../../config/rofi;
    ".config/touchegg".source    = ../../config/touchegg;
    ".config/wezterm".source     = ../../config/wezterm;
    ".config/zathura".source     = ../../config/zathura;

    # Ranger
    ".config/ranger/rc.conf".source    = ../../config/ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ../../config/ranger/rifle.conf;
    ".config/ranger/scope.sh".source   = ../../config/ranger/scope.sh;

    # Emacs
    ".config/emacs/emacs.org".source                = ../../config/emacs/emacs.org;
    ".config/emacs/init.el".source                  = ../../config/emacs/init.el;
    ".config/emacs/style.css".source                = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.png".source               = ../../config/emacs/banner.png;

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source   = ../../config/nvim/colors;
  };
}
