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

  environment.systemPackages = with pkgs; [ # Some games
    retroarchFull
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.startx.enable = true;
  };

  services.getty.autologinUser = "matei";
}
