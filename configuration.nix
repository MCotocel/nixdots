{ config, pkgs, ... }:

{
  # Import additional files
  imports =
    [
      ./hardware-configuration.nix # Hardware scan
    ];

  # Bootloader for efi
  boot.loader = {
    systemd-boot.enable = true; # Bootloader
    efi.canTouchEfiVariables = true;
  };

  # Network settings
  networking = {
    hostName = "blizzard"; # Hostname
    # wireless.enable = true; # Wireless
    useDHCP = false; # Deprecated, so set to false
    interfaces.ens33.useDHCP = true;
  };

  # Time
  time.timeZone = "Asia/Dubai"; # Time zone

  # X11
  services.xserver = {
    enable = true;
    layout = "us";
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # User accounts
  users.users.matei = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # For sudo
    shell = pkgs.zsh;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    trash-cli
  ];

  fonts.fonts = with pkgs; [
    iosevka
  ];
  
  console.font = "Iosevka Regular";

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''experimental-features = nix-command flakes ca-references'';
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };

  # System version, do not change
  system.stateVersion = "21.11";

}

