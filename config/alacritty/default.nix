{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 20;
        y = 20;
      };
      window.decorations = "None";
      font = {
        normal = {
          family = "Iosevka NF";
        };
      };
      colors = {
        primary = {
          foreground = "#d5d5d5";
          background = "#0c1213";
        };
        normal = {
          black = "#0c1213";
          red = "#ff8080";
          green = "#97d59b";
          yellow = "#fffe80";
          blue = "#80d1ff";
          magenta = "#c780ff";
          cyan = "#ace1ff";
          white = "#d5d5d5";
        };
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Never";
        };
      };
    };
  };
}
