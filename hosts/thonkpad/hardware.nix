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
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; # For my stupid GPU
    nvidia.modesetting.enable = true;
    nvidia.prime.nvidiaBusId = "PCI:1:0:0"; # Also for my stupid GPU
    nvidia.prime.intelBusId = "PCI:0:2:0"; # For Intel
  };

  services.thermald.enable = lib.mkDefault true; # Keep temps in check
  services.fstrim.enable = true; # I have an SSD
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_MAX_PERF_ON_AC=100;
      CPU_MAX_PERF_ON_BAT=20;
    };
  };
  powerManagement.powertop.enable = true;

  fileSystems."/" = # Main disk
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" = # Boot drive
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices = # Swap drive (Don't use it much)
    [ { device = "/dev/disk/by-label/swap"; } ];

  
  environment.systemPackages = with pkgs; [ # Better kernel
    linuxPackages_xanmod.r8168
  ];

  specialisation = { # For switching between displays
      external-display.configuration = {
        system.nixos.tags = [ "external-display" ];
        hardware.nvidia.prime.offload.enable = lib.mkForce false;
        hardware.nvidia.powerManagement.enable = lib.mkForce true;
      };
      internal-display.configuration = {
        system.nixos.tags = [ "internal-display" ];
        hardware.nvidia.prime.offload.enable = lib.mkForce true;
        hardware.nvidia.powerManagement.enable = lib.mkForce true;
      };
    };
}
