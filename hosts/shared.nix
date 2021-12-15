{ config, pkgs, ... }:

{

  # Time
  time.timeZone = "Asia/Dubai"; # Time zone

  # Bootloader for efi
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Security
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; noPass = true; keepEnv = true; }
    ];
  };

  # Nix and NixOS config
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  nixpkgs.config = {
    allowUnfree = true; # Forgive me Stallman
  };
}
