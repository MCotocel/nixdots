{ config, pkgs, ... }:

{
  # Hardware acceleration
  hardware.opengl = { # OpenGL for better performance
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };

  services.joycond.enable = true;

  environment.systemPackages = with pkgs; [ # Some games
    brutality
    cataclysm-dda-git
    citra
    dolphin-emu-beta
    dwarf-fortress
    dwarf-fortress-packages.themes.vettlingr
    #grapejuice
    gzdoom
    lutris
    mangohud
    minecraft
    minetest
    nethack
    optifine
    osu-lazer
    pcsx2
    protonup
    retroarchFull
    rpcs3
    steam-rom-manager
    steamcmd
    superTuxKart
    xorg.xf86inputjoystick
    yuzu-mainline
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
  
  services.power-profiles-daemon.enable = false; # Power profiles
  services.upower.enable = true; # UPower
}