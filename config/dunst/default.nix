{ config, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        shrink = true;
        frame_color = "#000000";
        font = "Iosevka Nerd Font 11";
      };
      urgency_normal = {
        background = "#000000";
        foreground = "#d5d5d5";
        timeout = 5;
      };
      urgency_critical = {
        background = "#000000";
        foreground = "#d5d5d5";
        timeout = 15;
      };
    };
  };
}
