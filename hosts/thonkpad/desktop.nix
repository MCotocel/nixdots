{ config, pkgs, ... }:

let
  kmonad =  import ../../derivations/kmonad.nix;
in {

  environment.systemPackages = with pkgs; [
    #aseprite
    obsidian
    baobab
    bleachbit
    blender
    brightnessctl
    bspwm
    calibre
    capitaine-cursors
    discocss
    discord
    eww
    filezilla
    firefox
    firejail
    fractal
    gimp
    giph
    gnome.gnome-calendar
    gnome.gnome-chess
    gnome.gnome-dictionary
    gnome.gnome-disk-utility
    gnome.nautilus
    gnome.gnome-system-monitor
    #googleearth-pro
    i3lock-color
    inkscape
    kid3
    kmonad
    krita
    libinput
    libnotify
    lm_sensors
    maim
    matcha-gtk-theme
    mesa
    networkmanagerapplet
    nitrogen
    nyxt
    openbox
    papirus-icon-theme
    picom
    qbittorrent
    qemu
    qutebrowser
    river
    rofi
    scrot
    solaar
    spicetify-cli
    swaybg
    sxhkd
    teams
    tesseract
    texlive.combined.scheme-full
    thunderbird
    twemoji-color-font
    twitter-color-emoji
    usbutils
    virt-manager
    wayfire
    wayland
    wezterm
    wine
    winetricks
    wmctrl
    wpa_supplicant
    xclip
    xdotool
    xorg.xf86videoamdgpu
    xorg.xinit
    xscreensaver
    zathura
  ];

  # Touchegg
  services.touchegg.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    xkbOptions = "caps:ctrl_modifier"; # Caps to control
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33;
    libinput.enable = true; # Enable libinput for trackpad
    displayManager.startx.enable = true;
    desktopManager = {
      gnome = {
        enable = false;
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
