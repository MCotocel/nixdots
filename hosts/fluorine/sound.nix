{ config, pkgs, ... }:

{
  # Sound
  sound.enable = false; # We want to use pipewire
  services.pipewire = { # Why? Because pipewire is hip and trendy
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
