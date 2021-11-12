{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
      #initrd = {
      #    availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      #    kernelModules = [ "amdgpu" ];
      #};
      kernelModules = [ "kvm-intel" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
      kernelParams = [ "intel_iommu=on" "pcie_aspm=off" ];
      blacklistedKernelModules = [ "radeon" ];
      extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ]; # Drivers
      kernelPackages = pkgs.linuxPackages_xanmod; # Kernel package
      extraModprobeConfig = ''
        options vfio-pci ids=1002:699f
        options kvm ignore_msrs=1
      '';
      postBootCommands = ''
        for DEV in "0000:02:00.0"; do
          echo "vfio-pci > /sys/bus/pci/devices/$DEV/drver_override
        done
        modprobe -i vfio-pci
        touch /dev/shm/looking-glass
        chown matei:kvm /dev/shm/looking-glass
        chmod 660 /dev/shm/looking-glass
      '';
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
