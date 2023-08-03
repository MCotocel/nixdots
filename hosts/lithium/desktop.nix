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

  # Fingerprint
  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };

  environment.systemPackages = with pkgs; [
    appimage-run # To run appimages when I need to
    arandr # Xrandr GUI
    aseprite # Pixel art is cool
    autorandr # Auto xrandr!
    baobab # For checking what's taking up so much disk space
    bitwarden # Passwords and stuff
    blender # Occasional tinkering with 3D models
    bottles # Wine prefix manager
    calibre # Converting my books for my Kindle
    cbatticon # Systray battery
    cinnamon.nemo # File manager
    dunst # For notifications
    eiskaltdcpp # DCPP client
    eww-wayland # Widgets for Hyprland
    filezilla # FTP program
    firefox # Main web browser
    firejail # When you want some extra security
    ffmpegthumbnailer # Video thumbnails
    flameshot # Screenshot tool
    fractal-next # Matrix client
    gimp # Photo editor
    giph # For taking videos
    gnome.file-roller # Unarchiver
    gnome.gnome-calendar # A calendar because I am a very busy person with no time at all
    gnome.gnome-disk-utility # Formatting disks. I think I use fdisk more though
    google-chrome
    gthumb # Image manager
    gtklock # GTK lock screen for wayland
    gtk3
    hicolor-icon-theme
    hexchat # IRC client
    hyperion-ng # Ambient lighting
    i3lock-color # For locking my device
    inkscape # Occasionally used
    kdenlive # Video editor
    kid3 # I download lots of music
    kmonad # For keyboard remapping
    krita # Sometimes used for posters and stuff
    libnotify # For sending notifications
    libreoffice # Office suite for Linux
    lxtask # Lightweight task manager
    maim # Select stuff
    mesa # The graphics thing
    networkmanagerapplet # When I want to quickly connect to a Wi-Fi network
    nicotine-plus # Soulseek client
    obs-studio # For recording my desktop
    obs-studio-plugins.obs-pipewire-audio-capture # For recording audio
    obsidian # I use this for all of my notes
    openssl # For certs
    p7zip # Unzipping stuff
    pan # Newsreader
    pandoc # Converting stuff
    pasystray # Control audio
    picom # A cool compositor
    poppler_utils # PDF stuff
    qbittorrent # For downloading certain things
    qemu # Woo VMs
    qpwgraph # Pipewire graph manager
    rofi-wayland # Used whenever I want to open an app
    scid # Chess GUI
    screenkey # Shows keys pressed
    shotwell # iPhone image importer
    solaar # For my Logitech mouse
    spicetify-cli # I used to rice spotify
    stockfish # Chess engine
    sway-contrib.grimshot # Screenshots
    swaybg # Set the background
    teams-for-linux # Very clunky but I need it
    tesseract # Images to text. Very cool
    texlive.combined.scheme-full # LaTeX package
    tor # Privacy yeah
    unrar # Extract rar fils
    usbutils # For my USB sticks
    virt-manager # For managing my virtual machines
    wayland # The cooler X
    wezterm # Best terminal
    wineWowPackages.stable # Who needs windows?
    winetricks # Who needs a CLI?
    wl-clipboard
    wmctrl # Moving windows around in scripts
    wpa_supplicant # Connecting to networks
    xclip # Copying stuff to my clipboard
    xdotool # Used for scrips
    xorg.xinit # So I can do startx when I log in
    xorg.xprop # For emacs-everywhere
    xscreensaver # Nice screensavers
    xsecurelock # Simple lock screen
    xorg.xwininfo # For emacs-everywhere
    yubikey-agent
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    yubikey-touch-detector
    zathura # For reading my downloaded PDFs
    zotero # Citation and stuff
  ];

  # Touchegg
  services.touchegg.enable = true; # I use my trackpad when on the go

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33; 
    libinput = {
      enable = true; # Enable libinput for trackpad
      touchpad.naturalScrolling = true;
    };
    #displayManager.startx.enable = true;
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
