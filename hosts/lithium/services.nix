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

  services.clamav = { # Antivirus for those weakling Windows users
  daemon.enable = false;
  updater = {
    enable = false;
    frequency = 24;
    interval = "hourly";
  };
  };

  services.syncthing = { # Syncing files
  enable = false;
  user = "matei";
  dataDir = "/home/matei";
  };

  services.logind.lidSwitch = "suspend"; # Power settings
  services.logind.lidSwitchDocked = "ignore"; # Quick access while plugged in
  services.logind.lidSwitchExternalPower = "ignore"; # Quick access while plugged in
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # For kmonad
  services.udev.extraRules =
    ''
      # KMonad user access to /dev/uinput
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    services.gvfs.enable = true; # For the Gnome apps
    services.tumbler.enable = true;
    services.locate.enable = true; # Locating files quickly
    programs.weylus.enable = false; # Sometimes use my tablet with this

    services.unclutter = { # Decluttering stuff
    enable = false;
    timeout = 3;
    };
}