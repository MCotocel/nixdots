{ config, pkgs, ... }:

{
  programs.home-manager.enable = true; # Enabling home-manager, really useful

  home.username = "matei"; # Yes, that is my name
  home.homeDirectory = "/home/matei"; # Directory path

  home.stateVersion = "21.11"; # Version

  imports = [
    (import ../../config/dunst { inherit config; })
    (import ../../config/emacs { inherit config; inherit pkgs; })
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
    ".config/neofetch".source = ../../config/neofetch;

    # Emacs
    #".config/emacs/init.el".source = ../../config/emacs/init.el;
    ".config/emacs/style.css".source = ../../config/emacs/style.css;
    ".config/emacs/doom-quiet-dark-theme.el".source = ../../config/emacs/doom-quiet-dark-theme.el;
    ".config/emacs/banner.txt".source = ../../config/emacs/banner.txt;

    # GTK
    ".config/gtklock.css".source = ../../config/gtklock.css;
    ".config/gtk-3.0/gtk.css".source = ../../config/gtk3.css;
    ".config/gtk-4.0/gtk.css".source = ../../config/gtk4.css;
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
