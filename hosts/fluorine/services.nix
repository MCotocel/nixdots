{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.duplicati = {
    enable = true;
    interface = "any";
  };
}
