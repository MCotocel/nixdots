{ config, pkgs, ... }:

{

  # Time
  time.timeZone = "Asia/Dubai"; # Time zone

  # Bootloader for efi
  boot.loader = {
    systemd-boot.enable = true;
    timeout = 1;
    efi.canTouchEfiVariables = true;
  };

  # Security
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    wheelNeedsPassword = false;
    extraConfig = "permit persist :wheel";
    extraRules = [
      { groups = [ "wheel" ]; noPass = false; keepEnv = true; persist = true; }
    ];
  };

  # Nix and NixOS config
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''experimental-features = nix-command flakes ca-references'';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
}
