{ config, pkgs, ... }:

{
  powerManagement.cpuFreqGovernor = "ondemand"; # When needed

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

  environment.systemPackages = with pkgs; [ # Some games
    cataclysm-dda
    lutris
    mangohud
    minecraft
    nethack
    osu-lazer
    retroarch
    superTuxKart
    zeroad
  ];

  programs.gamemode.enable = false; # Some stuff

  services.power-profiles-daemon.enable = false; # Power profiles
  services.upower.enable = true; # UPower
}
