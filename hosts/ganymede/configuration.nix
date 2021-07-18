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
  sound.enable = true;
  hardware.pulseaudio.enable = true; # Pulseaudio

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
  services.xserver.videoDrivers = [ "amdgpu" ]; # Use AMD driver
  hardware.opengl.driSupport = true; # DRI support
  hardware.opengl.driSupport32Bit = true;

  services.xserver.xkbOptions = "caps:ctrl_modifier"; # Caps to control

  services.xserver.windowManager = {
    awesome = {
      enable = true;
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

  # System-wide packages
  environment.systemPackages = with pkgs; [
    ack
    alacritty
    aria
    awesome
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
    firmwareLinuxNonfree
    fzf
    gh
    git
    htop
    imagemagick
    ispell
    isync
    jq
    linuxPackages_xanmod.r8168
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
    networkmanager
    onefetch
    picom
    python39
    ranger
    ripgrep
    river
    spicetify-cli
    steam
    swaybg
    telegraf
    telnet
    texlive.combined.scheme-small
    tmux
    trash-cli
    vim
    wayland
    wayfire
    wget
    wpa_supplicant
    wofi
    xorg.xf86videoamdgpu
    youtube-dl
    zsh
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; }) # Nerd Fonts
  ];
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ]; # Color for the console

  nixpkgs.overlays = [
    (final: prev: {
      awesome = (prev.awesome.overrideAttrs (old: rec {
        src = prev.fetchFromGitHub {
          owner = "awesomewm";
          repo = "awesome";
          rev = "149d18e0e796b3a439b1d79c5ee0c93febfcdf69";
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

  nixpkgs.config = {
    allowUnfree = true; # Allow unfree packages (forgive me stallman)
  };

  # System version, do not change
  system.stateVersion = "21.11";

}

