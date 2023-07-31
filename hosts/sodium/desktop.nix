{ config, lib, pkgs, system, ... }:

{

  # We're using caps lock for something else
  services.xserver.xkbOptions = "caps:none";

  # Lockscreen
  security.pam.services.gtklock = {
    text = ''
        auth sufficient pam_unix.so try_first_pass likeauth nullok
        auth sufficient	pam_fprintd.so
        auth include login
      '';
  };

  # For saving passwords and stuff
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  # Everything is bad without it
  programs.dconf.enable = true;

  # Phone and desktop integration
  programs.kdeconnect.enable = true;

  # Mail
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;
  services.gnome.evolution-data-server.plugins = [ pkgs.evolution-ews ];
  programs.evolution.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run # To run appimages when I need to
    bitwarden # Passwords and stuff
    blender # Occasional tinkering with 3D models
    bottles # Wine prefix manager
    cbatticon # Systray battery
    cinnamon.nemo # File manager
    dunst # For notifications
    eww-wayland # Widgets for Hyprland
    ffmpegthumbnailer # Video thumbnails
    firefox # Main web browser
    gnome.file-roller # Unarchiver
    gnome.gnome-disk-utility # Formatting disks. I think I use fdisk more though
    google-chrome
    gtklock # GTK lock screen for wayland
    hyperion-ng # Ambient lighting
    kmonad # For keyboard remapping
    libnotify # For sending notifications
    lxtask # Lightweight task manager
    mesa # The graphics thing
    obs-studio # For recording my desktop
    obs-studio-plugins.obs-pipewire-audio-capture # For recording audio
    qbittorrent # For downloading certain things
    qpwgraph # Pipewire graph manager
    rofi-wayland # Used whenever I want to open an app
    shotwell # iPhone image importer
    solaar # For my Logitech mouse
    spicetify-cli # I used to rice spotify
    sway-contrib.grimshot # Screenshots
    swaybg # Set the background
    unrar # Extract rar fils
    unzip # For unzipping archives
    wayland # The cooler X
    wezterm # Best terminal
    wineWowPackages.stable # Who needs windows?
    winetricks # Who needs a CLI?
    wl-clipboard
    wpa_supplicant # Connecting to networks
  ];

  # Touchegg
  services.touchegg.enable = true; # I use my trackpad when on the go

  # X11
  services.xserver = {
    enable = false;
    layout = "us"; # Set keyboard layout
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33; 
    libinput = {
      enable = true; # Enable libinput for trackpad
      touchpad.naturalScrolling = true;
    };
    displayManager.gdm.enable = true;
    windowManager = {
      awesome = { # Best window manager
        enable = false;
        package = pkgs.awesome-git; # We want the developer version
        luaModules = with pkgs.lua52Packages; [
          lgi
          ldbus
          luarocks-nix
          luadbi-mysql
          luaposix
        ];
      };
    };
  };

  programs.hyprland.enable = true; # Wayland yippee!

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ]; # My emoji font
      monospace = [ "Iosevka Nerd Font" ]; # Best monospace font
    };
    fonts = with pkgs; [
      noto-fonts # Fonts
      noto-fonts-cjk-sans # For CJK languages
      noto-fonts-extra # Fonts for languages
      twitter-color-emoji # Emoji
      montserrat # A very nice sans serif font
      (nerdfonts.override { fonts = [ "Iosevka" ]; }) # Nerdfonts for those cool ligatures and icons
    ];
  };

  qt.platformTheme = "gtk2";
  qt.style = "gtk2";

  environment.gnome.excludePackages = [ # Exclude all the stuff I don't need
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

  # My eyes must be preserved
  services.redshift = {
    enable = true;
    extraOptions = [
      "-l 24:54"
    ];
  };

  location = {
    provider = "manual";
    longitude = 54.0;
    latitude = 24.0;
  };
}
