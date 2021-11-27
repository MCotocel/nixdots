{ config, pkgs, ... }:

{

  # Touchegg
  services.touchegg.enable = true;

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    xkbOptions = "caps:ctrl_modifier"; # Caps to control
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33;
    libinput.enable = true; # Enable libinput for trackpad
    displayManager.gdm.enable = true; # Gnome display manager
    displayManager.defaultSession = "none+awesome";
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
        luaModules = with pkgs.lua52Packages; [
          lgi
          ldbus
          luarocks-nix
          luadbi-mysql
          luaposix
        ];
      };
      bspwm = {
        enable = true;
      };
    };
  };

  location.provider = "geoclue2";

  fonts = {
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
      monospace = [ "Iosevka Nerd Font" ];
    };
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  qt5.platformTheme = "gtk2";
  qt5.style = "gtk2";

  environment.gnome.excludePackages = [
    pkgs.gnome.file-roller
    pkgs.gnome.gedit
    pkgs.gnome.gnome-calendar
    pkgs.gnome.gnome-characters
    pkgs.gnome.gnome-chess
    pkgs.gnome.gnome-clocks
    pkgs.gnome.gnome-color-manager
    pkgs.gnome.gnome-contacts
    pkgs.gnome.gnome-dictionary
    pkgs.gnome.gnome-documents
    pkgs.gnome.gnome-font-viewer
    pkgs.gnome.gnome-logs
    pkgs.gnome.gnome-maps
    pkgs.gnome.gnome-music
    pkgs.gnome.gnome-screenshot
    pkgs.gnome.gnome-terminal
    pkgs.gnome.gnome-weather
    pkgs.gnome.simple-scan
    pkgs.gnome.totem
  ];

  services.autorandr.enable = true;
}
