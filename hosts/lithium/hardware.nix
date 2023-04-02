{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      };
      kernelModules = [ "kvm-intel" "fuse" ]; # Some modules
      kernelParams = [ "intel_iommu=on" ];
      kernelPackages = pkgs.linuxPackages_xanmod_latest; # Kernel package
  };

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };


  time.hardwareClockInLocalTime = true; # For Windows

  hardware = {
    enableAllFirmware = true; # Firmware stuff
    enableRedistributableFirmware = true; # More firmware stuff
    opengl.enable = true; # OpenGL stuff
    cpu.intel.updateMicrocode = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable; # For my stupid GPU
    };
  };

  services.thermald.enable = true; # Keep temps in check
  services.fstrim.enable = false; # I have an SSD
  services.tlp = {
    enable = true;
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
    #linuxPackages_xanmod.r8168
    linuxKernel.packages.linux_xanmod.hid-nintendo
  ];
}
