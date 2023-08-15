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
        settings = {
            PHOTOPRISM_ORIGINALS_PATH = "/home/matei/nas/media/";
            PHOTOPRISM_ADMIN_PASSWORD = "1234";
        };
      };
  };
}
