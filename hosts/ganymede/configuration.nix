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
    hostName = "ganymede"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    wireless.userControlled.enable = true; # Allow user to control networking
    networkmanager.enable = true; # Enable networkmanager
    wireless.networks = {
      "E_Net" = {
        psk = "silviu-1";
      };
    };
  };
  services.openssh.enable = true; # Enable openssh

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33;
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

  # Bluetooth
  hardware.bluetooth.enable = true; # Enable bluetooth
  services.blueman.enable = true; # Blueman service

  services.xserver.libinput.enable = true; # Enable libinput for trackpad

  # Antivirus
  services.clamav = {
    daemon.enable = false;
    updater = {
      enable = false;
      frequency = 24;
      interval = "hourly";
    };
  };

  # User accounts
  users.users.matei = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # For sudo/doas
    shell = pkgs.zsh;
  };

  services.xserver.displayManager.gdm.enable = true; # Gnome display manager
  #services.xserver.videoDrivers = [ "amdgpu" ]; # Use AMD driver
  hardware.opengl.driSupport = true; # DRI support
  hardware.opengl.driSupport32Bit = true;

  services.xserver.xkbOptions = "caps:ctrl_modifier"; # Caps to control

  services.xserver.windowManager = {
    awesome = {
      enable = true;
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
    xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  services.xserver.desktopManager = {
    xfce = {
      enable = false;
    };
    gnome = {
      enable = false;
    };
    plasma5 = {
      enable = false;
    };
  };

  # Configure closed lid actions
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";

  # Emacs
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsUnstable;

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
       github = {
         repositories = [
           "nixos/nixpkgs"
           "influxdata/influxdb"
         ];
         access_token = "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";
         http_timeout = "5s";
       };
       #ping = {
       #  urls = [
       #    "cache.nixos"
       #    "github.com"
       #    "stackoverflow.com"
       #    "google.com"
       #  ];
       #  count = 4;
       #  ping_interval = "5.0";
       #};
       mem = {};
       net = {};
       processes = {};
       system = {};
       temp = {};
       wireless = {};
      };
    };
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
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

  # Mopidy
  services.mopidy = {
    enable = true;
    configuration = with config.resources; ''
      [core]
      cache_dir = $XDG_CACHE_DIR/mopidy
      config_dir = $XDG_CONFIG_DIR/mopidy
      data_dir = $XDG_DATA_DIR/mopidy
      max_tracklist_length = 10000
      restore_state = false
      
      [logging]
      verbosity = 0
      format = %(levelname)-8s %(asctime)s [%(process)d:%(threadName)s] %(name)s\n  %(message)s
      color = true
      config_file =
      
      [audio]
      mixer = software
      mixer_volume =
      output = autoaudiosink
      buffer_time =
      
      [proxy]
      scheme =
      hostname =
      port =
      username =
      password =
      
      [file]
      enabled = true
      media_dirs =
        /Volumes/PiNAS/Media/Music|External
        ~/Mount|Homternal
        ~/|Home
      excluded_file_extensions =
      show_dotfiles = false
      follow_symlinks = true
      metadata_timeout = 1000
      
      [http]
      enabled = true
      hostname = 127.0.0.1
      port = 6680
      zeroconf = Mopidy HTTP server on $hostname
      allowed_origins =
      csrf_protection = true
      default_app = mopidy
      
      [m3u]
      enabled = true
      base_dir =
      default_encoding = latin-1
      default_extension = .m3u8
      playlists_dir =
      
      [softwaremixer]
      enabled = true
      
      [stream]
      enabled = true
      protocols =
       http
        https
        mms
        rtmp
        rtmps
        rtsp
      metadata_blacklist =
      timeout = 5000
      
      [mpd]
      enabled = true
      hostname = 127.0.0.1
      port = 6600
      password =
      max_connections = 20
      connection_timeout = 60
      zeroconf = Mopidy MPD server on $hostname
      command_blacklist =
        listall
        listallinfo
      default_playlist_scheme = m3u
    '';
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    ack
    alacritty
    apfs-fuse
    aria
    bash
    bat
    cmake
    cmatrix
    coreutils
    cowsay
    direnv
    discocss
    emacs-all-the-icons-fonts
    exa
    exfat
    fd
    ffmpeg
    firefox
    firmwareLinuxNonfree
    fzf
    gcc
    gh
    git
    htop
    imagemagick
    influxdb
    ispell
    isync
    jq
    libinput
    libvirt
    linuxPackages_xanmod.r8168
    manix
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
    networkmanager
    nyxt
    onefetch
    papirus-icon-theme
    pavucontrol
    pfetch
    pulseeffects-pw
    python39
    qemu
    ranger
    ripgrep
    river
    rofi
    scrot
    spicetify-cli
    sqlite
    steam
    swaybg
    telegraf
    telnet
    texlive.combined.scheme-small
    tigervnc
    tmux
    trash-cli
    usbutils
    vim
    wayfire
    wayland
    wget
    wofi
    wpa_supplicant
    xorg.xev
    xorg.xinit
    xorg.xf86videoamdgpu
    youtube-dl
    zsh

    nur.repos.fortuneteller2k.awesome-git
    nur.repos.reedrw.picom-next-ibhagwan
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; }) # Nerd Fonts
  ];
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ]; # Color for the console

  nixpkgs.overlays = [];

  nixpkgs.config = {
    allowUnfree = true; # Allow unfree packages (forgive me stallman)
  };

  # System version, do not change
  system.stateVersion = "21.11";

}

