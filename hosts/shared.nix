{ config, pkgs, ... }:

{
  # Time
  time.timeZone = "Asia/Dubai"; # Don't dox me guys

  # Bootloader for EFI
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Security
  security.sudo.enable = false; # Not a fan
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; noPass = true; keepEnv = true; } # Dangerous? Probably.
    ];
  };

  # Locales
  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  # Nix and NixOS config
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''experimental-features = nix-command flakes''; # I love flakes
  };

  nixpkgs.config = {
    allowUnfree = true; # Forgive me Stallman
  };
}
