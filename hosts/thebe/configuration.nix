{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader for efi
  boot.loader = {
    timeout = 1;
    grub.enable = true;
    grub.efiSupport = true;
    grub.device = "/dev/disk/by-label/nixos";
    grub.backgroundColor = "181e23";
    efi.canTouchEfiVariables = true;
  };

  # Network settings. No wifi because this is a VM
  networking = {
    hostName = "Thebe"; # Hostname
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
  
  console.colors = [ "181e23" "ff8080" "97d59b" "fffe80" "80d1ff" "c780ff" "80ffe4" "d5d5d5" "ffaeae" "bef8c1" "fcfba6" "ace1ff" "d8a8ff" "a2ffeb" "ffffff" ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''experimental-features = nix-command flakes ca-references'';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # System version, do not change
  system.stateVersion = "21.11";

}

