{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "i915" ];
    };
    kernelModules = [ "kvm-intel" "fuse" ]; # Some modules
    kernelParams = [
      "intel_iommu=on"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_level=3"
    ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest; # Kernel package
    tmp.useTmpfs = true; # Keep tmp files where they belong
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs " ];
    consoleLogLevel = 0;
    initrd.verbose = false;
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

  services.thermald.enable = true; # Keep temps in check
  services.fstrim.enable = true; # I have an SSD
  powerManagement.powertop.enable = true; # Battery and stuff
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      STOP_CHARGE_THRESH_BAT0 = "80";
    };
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
