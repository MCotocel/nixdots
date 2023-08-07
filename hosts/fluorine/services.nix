{ config, pkgs, kmonad, ... }:

{
  services.openssh.enable = true;
  services.tailscale.enable = true;
}
