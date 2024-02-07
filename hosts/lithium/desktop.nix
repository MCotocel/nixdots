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

  # Nautilus quick look
  services.gnome.sushi.enable = true;

  environment.systemPackages = with pkgs; [
    baobab # For checking what's taking up so much disk space
    bitwarden # Passwords and stuff
    bottles # Running Windows software
    calibre # Converting my books for my Kindle
    cbatticon # Systray battery
    darktable # Color correction
    dunst # For notifications
    element-desktop # Matrix client
    eww-wayland # Widgets for Hyprland
    ffmpegthumbnailer # Video thumbnails
    gimp # Photo editor
    gnome.file-roller # Unarchiver
    gnome.gnome-disk-utility # Formatting disks
    gnome.simple-scan # Scanner frontend
    gnome.nautilus # File manager
    google-chrome # Another browser, to separate work and not work
    gthumb # Image manager
    gtklock # GTK lock screen for wayland
    handbrake # Converting media
    inkscape # Occasionally used
    kdenlive # Video editor for the odd video task
    kmonad # For keyboard remapping
    krita # Sometimes used for posters and stuff
    libnotify # For sending notifications
    libreoffice # Office suite for Linux
    maim # Select stuff
    networkmanagerapplet # When I want to quickly connect to a Wi-Fi network
    nicotine-plus # Soulseek client
    openssl # For certs
    p7zip # Unzipping stuff
    pandoc # Converting stuff
    poppler_utils # PDF stuff
    qbittorrent # For downloading Linux ISOs
    qemu # Running VMs
    qpwgraph # Pipewire graph manager
    rofi-wayland # Rofi for app launching
    scid # Chess GUI
    socat # Pipes and stuff
    solaar # For my MX Master 3 mouse
    stockfish # Chess engine
    sway-contrib.grimshot # Screenshots
    swaybg # Wallpaper for hyprland
    tesseract # Images to text. Very cool
    tex # LaTeX package
    unrar # Extract rar fils
    usbutils # For my USB sticks
    virt-manager # For managing my virtual machines
    vorta # Backup GUI for BorgBackup
    wayland # The cooler X
    wl-clipboard # Clipboard tool for Wayland
    wpa_supplicant # Connecting to networks
    xterm # X terminal emulator, as a backup
    yubikey-agent # For my Yubikey
    yubikey-manager # For my Yubikey 
    yubikey-manager-qt # For my Yubikey
    yubikey-personalization # For my Yubikey
    yubikey-personalization-gui # For my Yubikey
    yubikey-touch-detector # For my Yubikey
    zathura # For reading my downloaded PDFs
  ];

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
