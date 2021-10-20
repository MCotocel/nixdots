{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ]; # Drivers
  boot.kernelPackages = pkgs.linuxPackages_xanmod; # Kernel package
  hardware.enableRedistributableFirmware = true; # Non-free firmware

  # Network settings.
  networking = {
    hostName = "thonkpad"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    wireless.enable = false;
    #wireless.userControlled.enable = true; # Allow user to control networking
    networkmanager.enable = true; # Enable networkmanager
    firewall.enable = true;
  };

  # SSH
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Virtualisation
  virtualisation.libvirtd ={
    enable = false;
    qemuOvmf = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  # I forgot what this is
  programs.dconf.enable = true;

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    xkbOptions = "caps:ctrl_modifier"; # Caps to control
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33;
    libinput.enable = true; # Enable libinput for trackpad
    displayManager.gdm.enable = true; # Gnome display manager
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
    };
  };

  # Sound
  sound.enable = false;
  hardware.pulseaudio.enable = false; # Pulseaudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  # Bluetooth
  hardware.bluetooth.enable = true; # Enable bluetooth
  services.blueman.enable = true; # Blueman service

  # Antivirus
  services.clamav = {
    daemon.enable = true;
    updater = {
      enable = true;
      frequency = 24;
      interval = "hourly";
    };
  };

  # User accounts
  users.users.matei = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" ]; # For sudo/doas
    shell = pkgs.zsh;
  };

  # Hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];
  };

  # Configure closed lid actions
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";

  # Emacs
  services.emacs.enable = false;
  services.emacs.package = pkgs.emacsGit;

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
  };

  # Telegraf
  services.telegraf = {
    enable = true;
    extraConfig = {
      outputs = {
        influxdb = {
          database = "telegraf";
          username = "telegraf";
          password = "telegraf";
          urls = ["http://localhost:8086"];
        };
      };
      inputs = {
       cpu = {
         percpu = true;
         totalcpu = true;
       };
       disk = {
         mount_points = ["/"];
         ignore_fs = [
           "tmpfs"
           "devtmpfs"
           "devfs"
           "iso9660"
           "overlay"
           "aufs"
           "squashfs"
         ];
       };
       mem = {};
       net = {};
       processes = {};
       system = {};
       temp = {};
       wireless = {};
      };
    };
  };

  # Grafana
  services.grafana = {
    enable = true;
    port = 3000;
    domain = "localhost";
    protocol = "http";
  };

  # Influxdb
  services.influxdb = {
    enable = true;
  };

  # Plymouth splash
  boot.plymouth = {
    enable = true;
    theme = "spinfinity";
  };

  # Touchegg
  services.touchegg.enable = true;

  # Mpd
  services.mpd = {
    enable = true;
  };

  # Mopidy
  services.mopidy = {
    enable = false;
    extensionPackages = [
      pkgs.mopidy-mpd
      pkgs.mopidy-youtube
    ];
    configuration = ''
      [file]
      enabled = true
      media_dirs =
        /Volumes/PiNAS/Media/Music|External
        ~/Mount/Media/Music|Homternal
        ~/|Home
      excluded_file_extensions = .nfo
      show_dotfiles = false
      follow_symlinks = true
      
      [mpd]
      enabled = true

      [youtube]
      enabled = true
    '';
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    alsa-utils
    apfs-fuse
    aria
    baobab
    bash
    bat
    bleachbit
    brightnessctl
    bspwm
    capitaine-cursors
    cava
    cmake
    cmatrix
    coreutils
    cowsay
    direnv
    discocss
    discord
    easyeffects
    emacs-all-the-icons-fonts
    emacsGit
    eww
    exa
    exfat
    fd
    feh
    ffmpeg
    firefox
    firejail
    firmwareLinuxNonfree
    fractal
    fzf
    gcc
    gh
    gimp
    giph
    git
    gnome.geary
    htop
    i3lock-color
    imagemagick
    influxdb
    inkscape
    ispell
    isync
    jq
    kid3
    krita
    libinput
    libnotify
    linuxPackages_xanmod.r8168
    lm_sensors
    lynis
    maim
    manix
    mesa
    mesa-demos
    minecraft
    mopidy
    mpc_cli
    mpd
    mpv
    mu
    ncdu
    ncmpcpp
    neofetch
    neovim
    nethack
    networkmanagerapplet
    nitrogen
    nodejs
    nyxt
    onefetch
    openbox
    openimagedenoise
    pamixer
    papirus-icon-theme
    pavucontrol
    pciutils
    pfetch
    playerctl
    pulseaudio
    pulsemixer
    python39
    qbittorrent
    qemu
    qutebrowser
    radeontop
    radeontop
    ranger
    ripgrep
    river
    rofi
    scrot
    shellcheck
    solaar
    speedtest-cli
    spicetify-cli
    spotify
    sqlite
    steam
    superTuxKart
    swaybg
    sxhkd
    teams
    telegraf
    telnet
    tesseract
    texlive.combined.scheme-small
    tigervnc
    tmux
    trash-cli
    ueberzug
    usbutils
    vim
    virt-manager
    wayfire
    wayland
    wezterm
    wget
    wine
    winetricks
    wmctrl
    wpa_supplicant
    xclip
    xdotool
    xfce.thunar
    xorg.xev
    xorg.xf86videoamdgpu
    xorg.xinit
    youtube-dl
    zathura
    zeroad
    zsh

    nur.repos.reedrw.picom-next-ibhagwan
  ];
  
  # Nerd Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ]; # Color for the console

  # System version, do not change
  system.stateVersion = "21.11";

}
