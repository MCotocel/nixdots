{ config, pkgs, lib, ... }:

{
  services.pipewire = { # Why? Because pipewire is hip and trendy
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alsa-utils # Utlities for alsa
    playerctl # Song control
    pulseaudio # For some apps
    pulsemixer # TUI mixer
    spotify # I love music
    vlc # GUI video player
  ];
}
