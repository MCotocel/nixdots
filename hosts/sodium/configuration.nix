{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ./code.nix
      ../shared.nix
    ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot = {
	kernelPackages = pkgs.linuxPackages_rpi4;
	tmpOnTmpfs = true;
	initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
	kernelParams = [
		"8250.nr_uarts=1"
		"console=ttyAMA0,115200"
		"console=tty1"
	];
  };

  networking.hostName = "sodium";
  networking.networkmanager.enable = true;

  users.users.matei = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     shell = pkgs.zsh;
     password = "1234";
   };

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "22.05";

}

