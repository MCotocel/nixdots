{ config, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        shrink = true;
        frame_color = "#1f252a";
        font = "Iosevka Nerd Font 11";
      };
      urgency_normal = {
        background = "#181e23";
        foreground = "#d5d5d5";
        timeout = 5;
      };
      urgency_critical = {
        background = "#181e23";
        foreground = "#d5d5d5";
        timeout = 15;
      };
    };
  };
}
