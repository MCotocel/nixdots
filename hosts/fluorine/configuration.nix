{ config, pkgs, ... }:

{
  imports =
    [
      ../shared.nix
      ./code.nix
      ./gaming.nix
      ./grafana.nix
      ./hardware.nix
      ./services.nix
      ./sound.nix
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

  networking.hostName = "fluorine";
  networking.networkmanager.enable = true;
  networking.interfaces.wlan0.ipv4.addresses = [ {
    address = "192.168.168.211";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "192.168.168.211";

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

