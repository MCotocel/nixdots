{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
          kernelModules = [ "amdgpu" ];
      };
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [ ];
      kernelParams = [ "intel_iommu=on" ];
      blacklistedKernelModules = [ "radeon" ];
  };

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

  powerManagement.cpuFreqGovernor = "ondemand";
}
