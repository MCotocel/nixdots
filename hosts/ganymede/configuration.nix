{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  # Network settings.
  networking = {
    hostName = "ganymede"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
    wireless.userControlled.enable = true;
    networkmanager.enable = true;
    wireless.networks = {
      "E_Net" = {
        psk = "silviu-1";
      };
    };
  };
  services.openssh.enable = true;

  hardware.enableRedistributableFirmware = true;

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
    extraGroups = [ "wheel" "networkmanager" ]; # For sudo/doas and networking
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
      enable = false;
    };
    plasma5 = {
      enable = true;
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    ack
    awesome
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
    linuxPackages.r8168
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
    spicetify-cli
    telegraf
    telnet
    texlive.combined.scheme-small
    tmux
    trash-cli
    vim
    wpa_supplicant
    wget
    xorg.xf86videoamdgpu
    youtube-dl
    zsh
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ];

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

  # System version, do not change
  system.stateVersion = "21.11";

}

