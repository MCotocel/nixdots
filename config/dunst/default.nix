{ config, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        shrink = true;
        frame_color = "#0f1719";
        font = "Iosevka Nerd Font 11";
      };
      urgency_normal = {
        background = "#0c1213";
        foreground = "#d5d5d5";
        timeout = 5;
      };
      urgency_critical = {
        background = "#0c1213";
        foreground = "#d5d5d5";
        timeout = 15;
      };
    };
  };
}
