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

  musnix.enable = true;

  environment.systemPackages = with pkgs; [
    alsa-utils # Utlities for alsa
    ardour # DAW for music recording
    audacity # Editing audio
    easyeffects # Audio effects
    guitarix # Digital guitar amp stuff
    gxplugins-lv2 # Plugins for guitarix
    ladspaPlugins # We need more plugins
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
    zyn-fusion # Synthesizer thingy
  ];
}
