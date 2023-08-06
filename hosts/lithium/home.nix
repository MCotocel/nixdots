{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  home.file = { # Files and stuff
    "Pictures/Wallpaper".source = ../../config/wallpaper;
    ".bin".source = ../../config/bin;
    ".local/share/applications".source = ../../config/applications;
    
    ".Xresources".source = ../../config/xresources;
    ".zshrc".source = ../../config/zshrc;
    ".config/touchegg/touchegg.conf".source = ../../config/touchegg/touchegg.conf;

    ".config/gzdoom/gzdoom.ini".source = ../../config/gzdoom/gzdoom.ini;

    ".config/awesome".source = ../../config/awesome;
    ".config/btop".source = ../../config/btop;
    ".config/cava".source = ../../config/cava;
    ".config/eww".source = ../../config/eww;
    ".config/hypr".source = ../../config/hypr;
    ".config/kmonad".source = ../../config/kmonad;
    ".config/ncmpcpp".source = ../../config/ncmpcpp;
    ".config/neofetch".source = ../../config/neofetch;
    ".config/picom".source = ../../config/picom;
    ".config/rofi".source = ../../config/rofi;
    ".config/wezterm".source = ../../config/wezterm;
    ".config/zathura".source = ../../config/zathura;

    # Ranger
    ".config/ranger/rc.conf".source = ../../config/ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ../../config/ranger/rifle.conf;
    ".config/ranger/scope.sh".source = ../../config/ranger/scope.sh;

    # Emacs
    ".config/emacs/init.el".source = ../../config/emacs/init.el;
    ".config/emacs/style.css".source = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.png".source = ../../config/emacs/banner.png;
    ".config/emacs/banner.txt".source = ../../config/emacs/banner.txt;

    # Vim
    ".config/nvim/init.vim".source = ../../config/nvim/init.vim;
    ".config/nvim/colors".source = ../../config/nvim/colors;

    # GTK
    ".config/gtklock.css".source = ../../config/gtklock.css;
    ".config/gtk-3.0/gtk.css".source = ../../config/gtk3.css;
    ".config/gtk-4.0/gtk.css".source = ../../config/gtk4.css;

    # Dunst
    ".config/dunstrc".source = ../../config/dunstrc;
  };

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.capitaine-cursors;
    cursorTheme.name = "Breeze_Snow";
    font.package = pkgs.source-sans-pro;
    font.name = "Source Sans Pro Regular";
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus-Dark";
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";
    gtk3.extraConfig = {
      Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
    };

    gtk4.extraConfig = {
      Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
    };
  };
}
