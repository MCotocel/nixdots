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
    alsa-util
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
