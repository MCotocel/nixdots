{ config, pkgs, ... }:

{
  services = {
      openssh.enable = true;
      tailscale.enable = true;
      duplicati = {
        enable = true;
        interface = "any";
      };
      photoprism = {
        enable = true;
        originalsPath = "/home/matei/nas/media";
        settings = {
            PHOTOPRISM_ADMIN_PASSWORD = "1234";
        };
      };
  };
}
