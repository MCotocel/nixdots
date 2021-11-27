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
