{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_rpi4; # Kernel package
  hardware.enableRedistributableFirmware = true; # Non-free firmware

  # Network settings.
  networking = {
    hostName = "applepie"; # Hostname
  };

  services.openssh.enable = true; # Enable openssh
  services.openssh.forwardX11 = true;

  # Avahi
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # User accounts
  users.users.matei = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # For sudo/doas
    shell = pkgs.zsh;
  };

  # Firewall
  networking.firewall = {
    enable = false;
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  # System version, do not change
  system.stateVersion = "21.11";

}

