{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "amdgpu" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams= [
    "iommu=soft"
    "radeon.ci_support=0"
    "amdgpu.si_support=1"
    "amdgpu.dc=1
  "];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  powerManagement.cpuFreqGovernor = "performance";
}
