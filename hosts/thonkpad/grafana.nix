{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ # Packages needed
    influxdb
    telegraf
  ];

  # Telegraf
  services.telegraf = { # For collection
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
  services.grafana = { # For displaying
    enable = true;
    port = 3000;
    domain = "localhost";
    protocol = "http";
    security.adminPassword = "1234";
  };

  # Influxdb
  services.influxdb = { # Also for collection
    enable = true;
  };
}
