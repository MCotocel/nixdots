{ config, pkgs, ... }:

{
  virtualisation.libvirtd ={
    enable = false;
    qemuOvmf = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  #programs.dconf.enable = true;

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.clamav = {
    daemon.enable = false;
    updater = {
      enable = false;
      frequency = 24;
      interval = "hourly";
    };
  };

  services.syncthing = {
    enable = true;
    user = "matei";
    dataDir = "/home/matei";
  };

  boot.plymouth = {
    enable = true;
    theme = "spinfinity";
  };

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
}
