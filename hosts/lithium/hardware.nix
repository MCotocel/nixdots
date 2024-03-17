{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "i915" "btintel" ];
    };
    kernelModules = [ "kvm-intel" "fuse" ];
    kernelParams =
      [ "intel_iommu=on" "splash" "boot.shell_on_fail" "i915.fastboot=1" ];
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  time.hardwareClockInLocalTime = true;

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
    ];
    cpu.intel.updateMicrocode = true;
  };

  services = {
    thermald.enable = true;
    fstrim.enable = true;
    power-profiles-daemon.enable = lib.mkForce false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        STOP_CHARGE_THRESH_BAT0 = "80";
      };
    };
    fwupd.enable = true;
    fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  powerManagement.powertop.enable = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    libinput
    lm_sensors
    pmutils
    powertop
  ];
}
