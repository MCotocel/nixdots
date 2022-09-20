{ config, pkgs, system, ... }:

{

  # For saving passwords and stuff
  services.gnome.gnome-keyring.enable = true;

  # Everything is bad without it
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    acpi # Battery and stuff
    appimage-run # To run appimages
    arandr # Xrandr GUI
    aseprite # Pixel art is cool
    autorandr # Auto xrandr!
    baobab # For checking what's taking up so much disk space
    bleachbit # For removing the files taking up so much disk space
    blender # Occasional tinkering with 3D models
    brightnessctl # Controlling brightness
    calibre # Converting my books for my Kindle
    capitaine-cursors # Nice cursors
    davinci-resolve # Video editing
    deemix-gui # Music downloading
    discocss # Customizing Discord CSS
    discord # Chat app
    dnd-tools # I play D&D so this is useful
    eww # Widgets for when I can't get the AwesomeWM ones working
    filezilla # FTP app
    firefox # Main web browser
    firejail # When you want some extra security
    fractal # Matrix client
    gimp # Photo editor
    giph # For taking videos
    gnome.file-roller # Unarchiver
    gnome.gnome-calendar # A calendar because I am a very busy person with no time at all
    gnome.gnome-disk-utility # Formatting disks. I think I use fdisk more though
    gnome.nautilus # File manager
    gnome.seahorse # Viewing keychain
    google-chrome
    googleearth-pro # When I want to explore the neighbourhood without going outside into a sandstorm
    gwe # Nvidia settings thingy
    i3lock-color # For locking my device
    inkscape # Occasionally used
    kid3 # I download lots of music
    krita # Sometimes used for posters and stuff
    libinput # I think this is for my trackpad
    libnotify # For sending notifications
    libreoffice # Office suite for Linux
    lm_sensors # Time to clean my fans out
    maim # Selecting an area for screenshots is useful
    matcha-gtk-theme # A cool GTK theme
    mesa # The graphics thing
    networkmanagerapplet # When I want to quickly connect to a Wi-Fi network
    nitrogen # Used to use it for setting my wallpaper
    noto-fonts # Fonts
    noto-fonts-cjk-sans # For CJK languages
    noto-fonts-extra # Fonts for languages
    nyxt # An interesting browser, similar to qutebrowser
    obs-studio # For recording my desktop
    obs-studio-plugins.obs-pipewire-audio-capture # For recording audio
    obsidian # I use this for all of my notes
    openbox # Neat floating window manager, I occasionally dabble in it
    openssl # For certs
    p7zip # Unzipping stuff
    pandoc # Converting stuff
    papirus-icon-theme # Best icon theme
    picom # A cool compositor
    pmutils # Power management utils I guess
    poppler_utils # PDF stuff
    qbittorrent # For downloading certain things
    qemu # Woo VMs
    qutebrowser # Secondary browser, controlled through my keyboard mostly
    river # Seems like a cool compostior for Wayland
    rofi # Used whenever I want to open an app
    scrot # Also for screenshots
    solaar # For my Logitech mouse
    spicetify-cli # I used to rice spotify
    swaybg # For setting the background on wayland
    sxhkd # Sometimes use this for other WMs
    teams # Very clunky but I need it
    tesseract # Images to text. Very cool
    texlive.combined.scheme-full # LaTeX package
    thunderbird # Email
    tor # Privacy yeah
    twemoji-color-font # Emoji
    twitter-color-emoji # Also emoji
    unrar # Extract rar fils
    upscayl
    usbutils # For my USB sticks
    virt-manager # For managing my virtual machines
    wayfire # It's fun to mess around with
    wayland # The cooler X
    wezterm # Best terminal
    wineWowPackages.stable # Who needs windows?
    winetricks # Who needs a CLI?
    wmctrl # Moving windows around in scripts
    wpa_supplicant # Connecting to networks
    xclip # Copying stuff to my clipboard
    xdotool # Used for scrips
    xorg.xinit # So I can do startx when I log in
    xscreensaver # Nice screensavers
    xsecurelock # Simple lock screen
    zathura # For reading my downloaded PDFs
  ];

  # Touchegg
  services.touchegg.enable = true; # I use my trackpad when on the go

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33; 
    libinput.enable = true; # Enable libinput for trackpad
    displayManager.startx.enable = true;
    videoDrivers = [ "nvidia" ]; # Didn't have much of a choice
    desktopManager = {
      plasma5 = {
        enable = false;
      };
    };
    windowManager = {
      awesome = { # Best window manager
        enable = true;
        package = pkgs.awesome-git; # We want the developer version
        luaModules = with pkgs.lua52Packages; [
          lgi
          ldbus
          luarocks-nix
          luadbi-mysql
          luaposix
        ];
      };
      bspwm = {
        enable = false;
      };
    };
  };

  fonts = {
    enableDefaultFonts = true;
    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ]; # My emoji font
      monospace = [ "Iosevka Nerd Font" ]; # Best monospace font
    };
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; }) # Nerdfonts for those cool ligatures and icons
    ];
  };

  qt5.platformTheme = "gtk2";
  qt5.style = "gtk2";

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
