{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
