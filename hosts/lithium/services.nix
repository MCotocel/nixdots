{ config, pkgs, kmonad, ... }:

{
  virtualisation.libvirtd = { # VMs are cool (and useful)
    enable = true;
    qemu.ovmf.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  virtualisation.docker.enable = true;

  services.printing = { # I need to print stuff off sometimes
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  hardware.bluetooth.enable = true; # Bluetooth cause why not
  services.blueman.enable = true; # Bluetooth GUI

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.syncthing = { # Syncing files
    enable = false;
    user = "matei";
    dataDir = "/home/matei";
  };

  services.logind.lidSwitch = "suspend"; # Power settings
  services.logind.lidSwitchDocked = "ignore"; # Quick access while plugged in
  services.logind.lidSwitchExternalPower =
    "ignore"; # Quick access while plugged in
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # For kmonad
  services.udev.extraRules = ''
    # KMonad user access to /dev/uinput
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    # Access hidraw devices
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
    # Allow video group to change brightness
    ACTION=="add", PROGRAM+="/run/current-system/sw/bin/chgrp video /sys/class/backlight/nvidia_wmi_ec_backlight/brightness"
    ACTION=="add", PROGRAM+="/run/current-system/sw/bin/chmod g+rw /sys/class/backlight/nvidia_wmi_ec_backlight/brightness"
  '';

  services.gvfs.enable = true; # For the Gnome apps
  services.tumbler.enable = true;
  services.locate.enable = true; # Locating files quickly
  services.tailscale.enable = true;
}
