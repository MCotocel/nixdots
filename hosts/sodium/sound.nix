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

  # Mpd
  services.mpd = { # Mopidy > mpd
    enable = false;
    musicDirectory = "/home/matei/Music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "127.0.0.1" # add this line - MPD must connect to the local sound server
      }
    '';
    network.listenAddress = "any";
  };

  environment.systemPackages = with pkgs; [
    alsa-utils # Utlities for alsa
    easyeffects # Audio effects
    pavucontrol # GUI mixer
    playerctl # Song control
    pulseaudio # For some apps
    spotify # I love music
    vlc # GUI video player
  ];
}
