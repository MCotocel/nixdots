{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      };
      kernelModules = [ "kvm-intel" ]; # For KVM
      kernelParams = [ "intel_iommu=on" ]; # Forgot what this does
      extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ]; # Drivers
      kernelPackages = pkgs.linuxPackages_xanmod_latest; # Kernel package
  };

  hardware = {
    enableAllFirmware = true; # Firmware stuff
    enableRedistributableFirmware = true; # More firmware stuff
    opengl.enable = true; # OpenGL stuff
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable; # For my stupid GPU
      prime.nvidiaBusId = "PCI:1:0:0"; # Also for my stupid GPU
      prime.intelBusId = "PCI:0:2:0"; # For Intel
      modesetting.enable = true;
      prime.offload.enable = lib.mkForce false;
      powerManagement.enable = lib.mkForce false;
    };
  };

  services.thermald.enable = lib.mkDefault false; # Keep temps in check
  services.fstrim.enable = false; # I have an SSD
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_MAX_PERF_ON_AC=100;
      CPU_MAX_PERF_ON_BAT=20;
      USB_AUTOSUSPEND=0;
    };
  };

  fileSystems."/" = # Main disk
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" = # Boot drive
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices = # Swap drive
    [ { device = "/dev/disk/by-label/swap"; } ];

  
  environment.systemPackages = with pkgs; [ # Better kernel
    linuxPackages_xanmod.r8168
  ];
}
