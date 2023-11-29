{ config, lib, pkgs, system, ... }:

let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full tikz-feynman;
  });
in
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
    baobab # For checking what's taking up so much disk space
    bitwarden # Passwords and stuff
    calibre # Converting my books for my Kindle
    cbatticon # Systray battery
    cinnamon.nemo # File manager
    dunst # For notifications
    eiskaltdcpp # DCPP client
    eww-wayland # Widgets for Hyprland
    firefox # Main web browser
    ffmpegthumbnailer # Video thumbnails
    gimp # Photo editor
    gnome.file-roller # Unarchiver
    gnome.gnome-calendar # A calendar because I am a very busy person with no time at all
    gnome.gnome-disk-utility # Formatting disks. I think I use fdisk more though
    google-chrome
    gthumb # Image manager
    gtklock # GTK lock screen for wayland
    gtklock-playerctl-module
    gtklock-powerbar-module
    gtklock-userinfo-module
    handbrake # Converting media
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
    microsoft-edge # Edge browser for video streaming
    networkmanagerapplet # When I want to quickly connect to a Wi-Fi network
    nicotine-plus # Soulseek client
    nyxt # Browser
    obs-studio # For recording my desktop
    obs-studio-plugins.obs-pipewire-audio-capture # For recording audio
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
    scid # Chess GUI
    screenkey # Shows keys pressed
    shotwell # iPhone image importer
    socat # Pipes and sturf
    solaar # For my Logitech mouse
    spicetify-cli # I used to rice spotify
    stockfish # Chess engine
    sway-contrib.grimshot # Screenshots
    swaybg # Set the background
    tesseract # Images to text. Very cool
    tex # LaTeX package
    unrar # Extract rar fils
    usbutils # For my USB sticks
    virt-manager # For managing my virtual machines
    vorta # Backup GUI for BorgBackup
    wayland # The cooler X
    wl-clipboard
    wmctrl # Moving windows around in scripts
    wpa_supplicant # Connecting to networks
    xterm # X terminal emulator
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
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = false;
    };
  };
  services.power-profiles-daemon.enable = lib.mkForce false;
  hardware.pulseaudio.enable = lib.mkForce false;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ]; # My emoji font
      monospace = [ "Iosevka Nerd Font" ]; # Best monospace font
    };
    packages = with pkgs; [
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
}
