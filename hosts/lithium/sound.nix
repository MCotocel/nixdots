{ config, pkgs, lib, ... }:

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
    alsa-utils # Utlities for also
    audacity # Ecsiditing audio
    easyeffects # Audio effects
    guitarix # Digital guitar amp stuff
    lmms # Making music
    mediainfo # Are my FLACs FLACs
    mpc_cli # MPD cli client
    mpd # MPD
    mpd-discord-rpc # Discord rich presence
    mpd-mpris # Control mpd with audio keys
    mpdevil # MPD GUI client
    mpv # Video player
    ncmpcpp # Mopidy front end
    pamixer # CLI mixer
    pavucontrol # GUI mixer
    picard # Music tagger
    playerctl # Song control
    pulseaudio # For some apps
    pulsemixer # TUI mixer
    python310Packages.deemix # I like offline MP3s
    scdl # For when I need to download from soundcloud
    spotify # I love music
    vcv-rack # I'm not rich enough for modular synths
    vlc # GUI video player
    zyn-fusion # Synthesizer
  ];
}
