{ config, pkgs, ... }:

{
  # Sound
  sound.enable = false;
  hardware.pulseaudio.enable = false; # Pulseaudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Mpd
  services.mpd = {
    enable = false;
  };


  environment.systemPackages = with pkgs; [
    alsa-utils
    easyeffects
    mopidy
    mpv
    ncmpcpp
    pamixer
    pavucontrol
    playerctl
    pulseaudio
    spotify
    vlc
    pulsemixer
    mpc_cli
    mpd
  ];

  # Mopidy
  services.mopidy = {
    enable = false;
    extensionPackages = [
      pkgs.mopidy-mpd
      pkgs.mopidy-youtube
    ];
    configuration = ''
      [file]
      enabled = true
      media_dirs =
        /Volumes/PiNAS/Media/Music|External
        ~/Mount/Media/Music|Homternal
        ~/|Home
      excluded_file_extensions = .nfo
      show_dotfiles = false
      follow_symlinks = true
      
      [mpd]
      enabled = true

      [youtube]
      enabled = true
    '';
  };
}
