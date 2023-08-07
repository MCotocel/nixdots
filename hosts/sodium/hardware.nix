{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "i915" ];
    };
    kernelModules = [ "kvm-intel" "fuse" ]; # Some modules
    kernelParams = [ "intel_iommu=on" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest; # Kernel package
    tmp.useTmpfs = true; # Keep tmp files where they belong
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs " ];
    plymouth = { enable = true; };
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
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
    ];
    cpu.intel.updateMicrocode = true;
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

  environment.systemPackages = with pkgs; [
    acpi # Battery and stuff
    brightnessctl # Brightness
    libinput # I think this is for my trackpad
    lm_sensors # Time to clean my fans out
    pmutils # Power management utils I guess
    powertop # View battery usage
  ];

  services.fwupd.enable = true;
}
