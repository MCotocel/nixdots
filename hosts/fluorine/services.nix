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
        originalsPath = "/var/lib/private/photoprism/originals";
        address = "0.0.0.0";
        settings = {
            PHOTOPRISM_ADMIN_PASSWORD = "1234";
        };
      };
  };
}
