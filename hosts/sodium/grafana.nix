{ config, pkgs, ... }:

{

  # Telegraf
  services.telegraf = { # For collection
    enable = true;
    extraConfig = {
      outputs = {
        influxdb = {
          database = "telegraf";
          username = "telegraf";
          password = "telegraf";
          urls = ["http://192.168.168.100:8086"];
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
        #ping = {
        #  urls = [
        #    "google.com"
        #    "outlook.com"
        #    "cloudflare.com"
        #    "store.steampowered.com"
        #  ];
        #  binary = "/run/wrappers/bin/ping";
        #  #ping_interval = 5;
        #};
        exec = {
          commands = [ "/run/current-system/sw/bin/speedtest --json" ];
          name_override = "speedtest";
          timeout = "1m";
          interval = "5m";
          data_format = "json";
          json_string_fields = [
            "interface_externalIp"
            "server_name"
            "server_location"
            "server_host"
            "server_ip"
            "result_url"
          ];
        };
        mem = {};
        net = {};
        processes = {};
        system = {};
        temp = {};
      };
    };
  };

  # Grafana
  services.grafana = { # For displaying
    enable = false;
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
