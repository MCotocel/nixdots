{ config, pkgs, ... }:

{
  powerManagement.cpuFreqGovernor = "ondemand";

  # Hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];
  };

  environment.systemPackages = with pkgs; [
    cataclysm-dda
    lutris
    minecraft
    nethack
    osu-lazer
    retroarch
    superTuxKart
    zeroad
  ];

  programs.gamemode.enable = false;

  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;
}
