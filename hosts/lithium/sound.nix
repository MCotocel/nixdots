{ config, pkgs, lib, ... }:

{
  # Sound
  security.rtkit.enable = true;
  services.pipewire = { # Why? Because pipewire is hip and trendy
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.mpd = {
    enable = true;
    user = "matei";
    musicDirectory = "/home/matei/State/Media/Music";
    network.listenAddress = "any";
    extraConfig = ''
      auto_update "yes"
      playlist_directory "/home/matei/State/Media/Music"

      audio_output {
        type "pipewire"
        name "Pipewire"
      }
    '';
  };

  systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/1000";
  };

  musnix.enable = true;

  environment.systemPackages = with pkgs; [
    alsa-utils # Utlities for alsa
    audacity # Editing audio
    easyeffects # Audio effects
    guitarix # Digital guitar amp stuff
    gxplugins-lv2 # Plugins for guitarix
    ladspaPlugins # We need more plugins
    lmms # DAW
    mpc_cli # MPD cli client
    mpd # MPD
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
    scdl # For when I need to download from soundcloud
    spotify # I love music
    vcv-rack # I'm not rich enough for modular synths
    vlc # GUI video player
    zyn-fusion # Synthesizer thingy
  ];
}
