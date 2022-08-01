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
    alsa-utils # Utlities for also
    easyeffects # Audio effects
    mopidy # Mpd but better
    mpc_cli # MPD cli client
    mpd # MPD
    mpd-discord-rpc # Discord rich presence
    mpd-mpris # Control mpd with audio keys
    mpdevil # MPD GUI client
    mpv # Video player
    ncmpcpp # Mopidy front end
    pamixer # CLI mixer
    pavucontrol # GUI mixer
    playerctl # Song control
    pulseaudio # For some apps
    pulsemixer # TUI mixer
    spotify # I love music
    vlc # GUI video player
  ];

  # Mopidy
  services.mopidy = {
    enable = false; # Can't be bothered right now
    extensionPackages = [
      pkgs.mopidy-mpd # Play from MPD
      pkgs.mopidy-youtube # Play from Youtube
    ];
    configuration = ''
      [local]
      enabled = true
      media_dirs =~/|Home

      [file]
      enabled = true
      media_dirs =
        ~/Mount/Media/Music|Homternal
        ~/|Home
      excluded_file_extensions = .nfo
      show_dotfiles = false
      follow_symlinks = true
      
      [mpd]
      enabled = true
      hostname = 127.0.0.1
      port = 6600

      [youtube]
      enabled = true
    '';
  };
}
