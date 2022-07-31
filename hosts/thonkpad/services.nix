{ config, pkgs, ... }:

{
  virtualisation.libvirtd = { # VMs are cool (and useful)
    enable = false;
    qemu.ovmf.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

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
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
  };

  boot.plymouth = { # Cool startup splash screen
    enable = false;
    theme = "spinfinity";
  };

  services.logind.lidSwitch = "suspend"; # Power settings
  services.logind.lidSwitchDocked = "ignore"; # Quick access while plugged in
  services.logind.lidSwitchExternalPower = "ignore"; # Quick access while plugged in

  programs.steam.enable = true; # I like my games
  services.gvfs.enable = true; # For the Gnome apps
  services.locate.enable = true; # Locating files quickly
  programs.weylus.enable = true; # Sometimes use my tablet with this

  services.unclutter = { # Decluttering stuff
    enable = true;
    timeout = 3;
  };
}
