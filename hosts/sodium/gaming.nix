{ config, pkgs, ... }:

{
  # Hardware acceleration
  hardware.opengl = { # OpenGL for better performance
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  services.joycond.enable = true;

  environment.systemPackages = with pkgs; [ # Some games
    cataclysm-dda-git
    dolphin-emu
    grapejuice
    mangohud
    minecraft
    minetest
    nethack
    optifine
    osu-lazer
    protonup
    retroarch
    rpcs3
    steam-rom-manager
    steamcmd
    xorg.xf86inputjoystick
    yuzu
  ];

  programs.gamemode = {
    enable = true; # Some stuff
    settings = {
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  programs.steam = { # I like my games
    enable = true;
    remotePlay.openFirewall = true; # Steam Remote Play
    dedicatedServer.openFirewall = true; # Source Dedicated Server
  };
  
  services.upower.enable = true; # UPower
}
