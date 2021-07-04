{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader for efi
  boot.loader = {
    timeout = 1;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Network settings. No wifi because this is a VM
  networking = {
    hostName = "thebe"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    interfaces.ens33.useDHCP = true;
  };

  # Time
  time.timeZone = "Asia/Dubai"; # Time zone

  # X11
  services.xserver = {
    enable = true;
    layout = "us";
    autoRepeatDelay = 225;
    autoRepeatInterval = 33;
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Security
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    wheelNeedsPassword = true;
    extraRules = [
      { groups = [ "wheel" ]; noPass = false; keepEnv = true; persist = true; }
    ];
  };
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
    extraGroups = [ "wheel" ]; # For sudo
    shell = pkgs.zsh;
  };

  services.xserver.windowManager = {
    awesome = {
      enable = false;
    };
    bspwm = {
      enable = false;
    };
  };

  services.xserver.desktopManager = {
    xfce = {
      enable = false;
    };
    gnome = {
      enable = true;
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    ack
    aria
    bash
    bat
    cmake
    cmatrix
    coreutils
    cowsay
    direnv
    discocss
    emacs
    exa
    fd
    ffmpeg
    fzf
    gh
    git
    htop
    imagemagick
    ispell
    isync
    jq
    manix
    mpc_cli
    mpd
    mpv
    mu
    ncdu
    ncmpcpp
    neofetch
    neovim
    nethack
    onefetch
    python39
    ranger
    ripgrep
    spicetify-cli
    telegraf
    telnet
    texlive.combined.scheme-small
    tmux
    trash-cli
    vim
    wget
    youtube-dl
    zsh
  ];

  fonts.fonts = with pkgs; [
    iosevka
  ];
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''experimental-features = nix-command flakes ca-references'';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      awesome = (prev.awesome.overrideAttrs (old: rec {
        src = prev.fetchFromGithub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "149f18e0e796b3a439b1d79c5ee0c93febfcdf69";
          sha256 = "02ahbph10sd5a4gv9wizcl0pmqd08mdc47w9bd28p5bldpk4vrvm";
        };
        GI_TYPELIB_PATH = "${prev.playerctl}/lib/girepository-1.0:"
          + "${prev.upower}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
      })).override {
       stdenv = prev.clangStdenv;
       luaPackages = prev.lua52Packages;
       gtk3Support = true;
      };
    })
  ];

  # System version, do not change
  system.stateVersion = "21.11";

}

