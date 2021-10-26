{ config, pkgs, ... }:

{

  # Touchegg
  services.touchegg.enable = true;

  # X11
  services.xserver = {
    enable = true;
    layout = "us"; # Set keyboard layout
    xkbOptions = "caps:ctrl_modifier"; # Caps to control
    autoRepeatDelay = 225; # Keyboard repeat rate
    autoRepeatInterval = 33;
    libinput.enable = true; # Enable libinput for trackpad
    displayManager.gdm.enable = true; # Gnome display manager
    displayManager.defaultSession = "none+awesome";
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
        luaModules = with pkgs.lua52Packages; [
          lgi
          ldbus
          luarocks-nix
          luadbi-mysql
          luaposix
        ];
      };
      bspwm = {
        enable = true;
      };
    };
  };
}
