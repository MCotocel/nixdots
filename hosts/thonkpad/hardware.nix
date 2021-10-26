{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
          kernelModules = [ "amdgpu" ];
      };
      kernelModules = [ "kvm-intel" ];
      kernelParams = [ "intel_iommu=on" ];
      blacklistedKernelModules = [ "radeon" ];
      extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ]; # Drivers
      kernelPackages = pkgs.linuxPackages_xanmod; # Kernel package
  };

  hardware.enableRedistributableFirmware = true; # Non-free firmware

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; } ];

}
