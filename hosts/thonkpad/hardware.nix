{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      initrd = {
          availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      };
      kernelModules = [ "kvm-intel" ];
      kernelParams = [ "intel_iommu=on" ];
      extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ]; # Drivers
      kernelPackages = pkgs.linuxPackages_xanmod; # Kernel package
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidia.prime.nvidiaBusId = "PCI:1:0:0";
    nvidia.prime.intelBusId = "PCI:0:2:0";
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

  
  environment.systemPackages = with pkgs; [
    linuxPackages_xanmod.r8168
  ];

  specialisation = {
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
