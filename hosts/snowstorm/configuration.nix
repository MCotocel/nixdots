{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader for efi
  boot.loader = {
    systemd-boot.enable = true; # Bootloader
    efi.canTouchEfiVariables = true;
  };

  # Network settings. No wifi because this is a VM
  networking = {
    hostName = "snowstorm"; # Hostname
    useDHCP = false; # Deprecated, so set explicitly to false
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
    emacs
    git
    mpd
    ncmpcpp
    neovim
    vim
    wget
    zsh
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

