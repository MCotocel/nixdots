{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
    };
    kernelModules = [ "kvm-amd" ]; # Some modules
  };

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  fileSystems."/" = # Main disk
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" = # Boot drive
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  jovian.devices.steamdeck = {
    enable = true;
  };
}
