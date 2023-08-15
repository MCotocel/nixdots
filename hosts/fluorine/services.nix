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
        importsPath = "/home/matei/nas/media";
        originalsPath = "/home/matei/nas/pp";
        settings = {
            PHOTOPRISM_ADMIN_PASSWORD = "1234";
        };
      };
  };
}
