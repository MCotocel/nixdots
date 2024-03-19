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
          urls = [ "http://127.0.0.1:8086" ];
        };
      };
      inputs = {
        cpu = {
          percpu = true;
          totalcpu = true;
        };
        disk = {
          mount_points = [ "/" ];
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
        mem = { };
        net = { };
        processes = { };
        system = { };
        temp = { };
        filecount = {
          directories = [ "/home/matei/State/Vault" ];
          name = "*.org";
          recursive = false;
        };
      };
    };
  };

  # Grafana
  services.grafana = { # For displaying
    enable = true;
    settings.server.port = 3000;
    settings.server.domain = "0.0.0.0";
    settings.server.addr = "0.0.0.0";
    settings.server.protocol = "http";
    settings.security.admin_password = "1234";
  };

  # Influxdb
  services.influxdb = { # Also for collection
    enable = true;
  };
}
