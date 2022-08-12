{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      };
      kernelModules = [ "kvm-intel" ]; # For KVM
      kernelParams = [ "intel_iommu=on" ]; # Forgot what this does
      extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ]; # Drivers
      kernelPackages = pkgs.linuxPackages_xanmod; # Kernel package
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
        hardware.nvidia.powerManagement.enable = lib.mkForce false;
      };
      internal-display.configuration = {
        system.nixos.tags = [ "internal-display" ];
        hardware.nvidia.prime.offload.enable = lib.mkForce true;
        hardware.nvidia.powerManagement.enable = lib.mkForce true;
      };
    };
}
