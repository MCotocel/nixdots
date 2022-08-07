{ config, pkgs, ... }:

let
  kmonad =  import ../../derivations/kmonad.nix;
in {
  environment.systemPackages = with pkgs; [
    arandr # Xrandr GUI
    aseprite # Pixel art is cool
    baobab # For checking what's taking up so much disk space
    bleachbit # For removing the files taking up so much disk space
    blender # Occasional tinkering with 3D models
    brightnessctl # Controlling brightness
    calibre # Converting my books for my Kindle
    capitaine-cursors # Nice cursors
    discocss # Customizing Discord CSS
    discord # Chat app
    eww # Widgets for when I can't get the AwesomeWM ones working
    filezilla # FTP app
    firefox # Main web browser
    firejail # When you want some extra security
    fractal # Matrix client
    gimp # Photo editor
    giph # For taking videos
    gnome.gnome-calendar # A calendar because I am a very busy person with no time at all
    gnome.gnome-chess # Chess for when I'm not busy
    gnome.gnome-dictionary # For definitions of words cause I'm stupid
    gnome.gnome-disk-utility # Formatting disks. I think I use fdisk more though
    gnome.gnome-system-monitor # htop > *
    googleearth-pro # When I want to explore the neighbourhood without going outside into a sandstorm
    i3lock-color # For locking my device
    inkscape # Occasionally used
    kid3 # I download lots of music
    kmonad # I could be very efficient if I actually used it
    krita # Sometimes used for posters and stuff
    libinput # I think this is for my trackpad
    libnotify # For sending notifications
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
    papirus-icon-theme # Best icon theme
    picom # A cool compositor
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
    thunderbird # A nice email client
    twemoji-color-font # Emoji
    twitter-color-emoji # Also emoji
    usbutils # For my USB sticks
    virt-manager # For managing my virtual machines
    wayfire # It's fun to mess around with
    wayland # The cooler X
    wezterm # Best terminal
    wine # Who needs Windows?
    winetricks # Who needs a CLI?
    wmctrl # Moving windows around in scripts
    wpa_supplicant # Connecting to networks
    xclip # Copying stuff to my clipboard
    xdotool # Used for scrips
    xfce.thunar # Good file manager
    xorg.xinit # So I can do startx when I log in
    xscreensaver # Nice screensavers
    zathura # For reading my downloaded PDFs
  ];

  # Touchegg
  services.touchegg.enable = true; # I use my trackpad when on the go

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    xkbOptions = "caps:ctrl_modifier"; # Caps to control
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33; 
    libinput.enable = true; # Enable libinput for trackpad
    displayManager.startx.enable = true;
    videoDrivers = [ "nvidia" ]; # Didn't have much of a choice
    desktopManager = {
      gnome = {
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

  location.provider = "geoclue2"; # For stuff that needs my general location

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

  qt5.platformTheme = "gtk3";
  qt5.style = "gtk3";

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

  services.autorandr.enable = true; # I use an external monitor
}
