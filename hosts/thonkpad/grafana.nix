{ config, pkgs, ... }:

{
  # Telegraf
  services.telegraf = {
    enable = true;
    extraConfig = {
      outputs = {
        influxdb = {
          database = "telegraf";
          username = "telegraf";
          password = "telegraf";
          urls = ["http://localhost:8086"];
        };
      };
      inputs = {
       cpu = {
         percpu = true;
         totalcpu = true;
       };
       disk = {
         mount_points = ["/"];
         ignore_fs = [
           "tmpfs"
           "devtmpfs"
           "devfs"
           "iso9660"
           "overlay"
           "aufs"
           "squashfs"
         ];
       };
       mem = {};
       net = {};
       processes = {};
       system = {};
       temp = {};
       wireless = {};
      };
    };
  };

  # Grafana
  services.grafana = {
    enable = true;
    port = 3000;
    domain = "localhost";
    protocol = "http";
  };

  # Influxdb
  services.influxdb = {
    enable = true;
  };
}
