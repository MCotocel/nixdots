{ pkgs, ... }:

{
  # Enabling sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;

  # Playing local music files
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
  systemd.services.mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };

  # Real-time audio
  musnix.enable = true;

  environment.systemPackages = with pkgs; [
    alsa-utils
    audacity
    easyeffects
    guitarix
    gxplugins-lv2
    ladspaPlugins
    lmms
    mpc_cli
    mpd
    mpdevil
    mpv
    ncmpcpp
    pamixer
    pavucontrol
    picard
    playerctl
    pulseaudio
    pulsemixer
    scdl
    spotify
    vcv-rack
    vlc
    zyn-fusion
  ];
}
