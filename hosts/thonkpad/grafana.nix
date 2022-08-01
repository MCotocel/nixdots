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
        github = {
          repositories = [
            "NixOS/nixpkgs"
            "MCotocel/nixdots"
          ];
          access_token = "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"; # Don't worry, it can't do much at all
        };
        ping = {
          urls = [
            "google.com"
            "outlook.com"
            "cloudflare.com"
            "store.steampowered.com"
          ];
          binary = "/run/wrappers/bin/ping";
          #ping_interval = 5;
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
