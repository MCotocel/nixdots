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
    gtk3.extraCss = ''
        @define-color accent_color #ace1ff;
        @define-color accent_bg_color #ace1ff;
        @define-color accent_fg_color #181e23;
        @define-color destructive_color #ff8080;
        @define-color destructive_bg_color #ff8080;
        @define-color destructive_fg_color #181e23;
        @define-color success_color #97d59b;
        @define-color success_bg_color #97d59b;
        @define-color success_fg_color #181e23;
        @define-color warning_color #fffe80;
        @define-color warning_bg_color #fffe80;
        @define-color warning_fg_color #181e23;
        @define-color error_color #ff8080;
        @define-color error_bg_color #ff8080;
        @define-color error_fg_color #181e23;
        @define-color window_bg_color #181e23;
        @define-color window_fg_color #d5d5d5;
        @define-color view_bg_color #181e23;
        @define-color view_fg_color #d5d5d5;
        @define-color headerbar_bg_color #181e23;
        @define-color headerbar_fg_color #d5d5d5;
        @define-color headerbar_border_color #1f252a;
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
        @define-color card_bg_color #181e23;
        @define-color card_fg_color #d5d5d5;
        @define-color card_shade_color rgba(0, 0, 0, 0.07);
        @define-color dialog_bg_color #181e23;
        @define-color dialog_fg_color #d5d5d5;
        @define-color popover_bg_color #181e23;
        @define-color popover_fg_color #d5d5d5;
        @define-color shade_color rgba(0, 0, 0, 0.07);
        @define-color scrollbar_outline_color #181e23;
        @define-color blue_1 #99c1f1;
        @define-color blue_2 #62a0ea;
        @define-color blue_3 #3584e4;
        @define-color blue_4 #1c71d8;
        @define-color blue_5 #1a5fb4;
        @define-color green_1 #8ff0a4;
        @define-color green_2 #57e389;
        @define-color green_3 #33d17a;
        @define-color green_4 #2ec27e;
        @define-color green_5 #26a269;
        @define-color yellow_1 #f9f06b;
        @define-color yellow_2 #f8e45c;
        @define-color yellow_3 #f6d32d;
        @define-color yellow_4 #f5c211;
        @define-color yellow_5 #e5a50a;
        @define-color orange_1 #ffbe6f;
        @define-color orange_2 #ffa348;
        @define-color orange_3 #ff7800;
        @define-color orange_4 #e66100;
        @define-color orange_5 #c64600;
        @define-color red_1 #f66151;
        @define-color red_2 #ed333b;
        @define-color red_3 #e01b24;
        @define-color red_4 #c01c28;
        @define-color red_5 #a51d2d;
        @define-color purple_1 #dc8add;
        @define-color purple_2 #c061cb;
        @define-color purple_3 #9141ac;
        @define-color purple_4 #813d9c;
        @define-color purple_5 #613583;
        @define-color brown_1 #cdab8f;
        @define-color brown_2 #b5835a;
        @define-color brown_3 #986a44;
        @define-color brown_4 #865e3c;
        @define-color brown_5 #63452c;
        @define-color light_1 #ffffff;
        @define-color light_2 #f6f5f4;
        @define-color light_3 #deddda;
        @define-color light_4 #c0bfbc;
        @define-color light_5 #9a9996;
        @define-color dark_1 #77767b;
        @define-color dark_2 #5e5c64;
        @define-color dark_3 #3d3846;
        @define-color dark_4 #241f31;
        @define-color dark_5 #000000;
    '';
    gtk4.extraConfig = {
      Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
    };
    gtk4.extraCss = ''
        @define-color accent_color #ace1ff;
        @define-color accent_bg_color #ace1ff;
        @define-color accent_fg_color #181e23;
        @define-color destructive_color #ff8080;
        @define-color destructive_bg_color #ff8080;
        @define-color destructive_fg_color #181e23;
        @define-color success_color #97d59b;
        @define-color success_bg_color #97d59b;
        @define-color success_fg_color #181e23;
        @define-color warning_color #fffe80;
        @define-color warning_bg_color #fffe80;
        @define-color warning_fg_color #181e23;
        @define-color error_color #ff8080;
        @define-color error_bg_color #ff8080;
        @define-color error_fg_color #181e23;
        @define-color window_bg_color #181e23;
        @define-color window_fg_color #d5d5d5;
        @define-color view_bg_color #181e23;
        @define-color view_fg_color #d5d5d5;
        @define-color headerbar_bg_color #181e23;
        @define-color headerbar_fg_color #d5d5d5;
        @define-color headerbar_border_color #1f252a;
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
        @define-color card_bg_color #181e23;
        @define-color card_fg_color #d5d5d5;
        @define-color card_shade_color rgba(0, 0, 0, 0.07);
        @define-color dialog_bg_color #181e23;
        @define-color dialog_fg_color #d5d5d5;
        @define-color popover_bg_color #181e23;
        @define-color popover_fg_color #d5d5d5;
        @define-color shade_color rgba(0, 0, 0, 0.07);
        @define-color scrollbar_outline_color #181e23;
        @define-color blue_1 #99c1f1;
        @define-color blue_2 #62a0ea;
        @define-color blue_3 #3584e4;
        @define-color blue_4 #1c71d8;
        @define-color blue_5 #1a5fb4;
        @define-color green_1 #8ff0a4;
        @define-color green_2 #57e389;
        @define-color green_3 #33d17a;
        @define-color green_4 #2ec27e;
        @define-color green_5 #26a269;
        @define-color yellow_1 #f9f06b;
        @define-color yellow_2 #f8e45c;
        @define-color yellow_3 #f6d32d;
        @define-color yellow_4 #f5c211;
        @define-color yellow_5 #e5a50a;
        @define-color orange_1 #ffbe6f;
        @define-color orange_2 #ffa348;
        @define-color orange_3 #ff7800;
        @define-color orange_4 #e66100;
        @define-color orange_5 #c64600;
        @define-color red_1 #f66151;
        @define-color red_2 #ed333b;
        @define-color red_3 #e01b24;
        @define-color red_4 #c01c28;
        @define-color red_5 #a51d2d;
        @define-color purple_1 #dc8add;
        @define-color purple_2 #c061cb;
        @define-color purple_3 #9141ac;
        @define-color purple_4 #813d9c;
        @define-color purple_5 #613583;
        @define-color brown_1 #cdab8f;
        @define-color brown_2 #b5835a;
        @define-color brown_3 #986a44;
        @define-color brown_4 #865e3c;
        @define-color brown_5 #63452c;
        @define-color light_1 #ffffff;
        @define-color light_2 #f6f5f4;
        @define-color light_3 #deddda;
        @define-color light_4 #c0bfbc;
        @define-color light_5 #9a9996;
        @define-color dark_1 #77767b;
        @define-color dark_2 #5e5c64;
        @define-color dark_3 #3d3846;
        @define-color dark_4 #241f31;
        @define-color dark_5 #000000;
    '';
  };
}
