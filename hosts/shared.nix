{ config, pkgs, ... }:

{
  # Time
  time.timeZone = "Asia/Dubai";

  # Security
  security.sudo.enable = false; # Not a fan
  security.doas = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      noPass = false;
      keepEnv = true;
      persist = true;
    }];
    extraConfig = ''
      permit nopass :wheel as root cmd nix
      permit nopass :wheel as root cmd nix-collect-garbage
      permit nopass :wheel as root cmd nix-env
      permit nopass :wheel as root cmd nix-store
      permit nopass :wheel as root cmd nixos-rebuild
      permit nopass :wheel as root cmd reboot
      permit nopass :wheel as root cmd shutdown
      permit nopass :wheel as root cmd sync
      permit nopass :wheel as root cmd tee
    '';
  };

  # Locales
  i18n = { defaultLocale = "en_GB.UTF-8"; };

  # Nix and NixOS config
  nix = {
    settings = {
      show-trace = true;
    };
    package = pkgs.nixUnstable;
    extraOptions = "experimental-features = nix-command flakes"; # I love flakes
    nixPath = [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true; # Forgive me Stallman
  };
}
