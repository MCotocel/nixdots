{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run";
      icon-theme = "Papirus";
      parse-system = false;
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        ac = mkLiteral "#0f1719";
        bg = mkLiteral "#0c1213";
        fg = mkLiteral "#d5d5d5";
        background-color = mkLiteral "@bg";
      };

      "window" = {
        padding = mkLiteral "20px";
        width = mkLiteral "30%";
        height = mkLiteral "40%";
        border = mkLiteral "3px";
        border-color = mkLiteral "@ac";
      };

      "prompt" = { text-color = mkLiteral "@fg"; };

      "textbox-prompt-colon" = {
        expand = false;
        str = " - ";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        spacing = 0;
        text-color = mkLiteral "@fg";
      };

      "inputbar" = {
        text-color = mkLiteral "@fg";
        children = map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" ];
      };

      "listview" = {
        padding = mkLiteral "5px 5px 5px 5px";
        columns = 3;
      };

      "element" = {
        border = mkLiteral "0px";
        border-radius = mkLiteral "0px";
        padding = mkLiteral "5px";
        text-color = mkLiteral "@fg";
        background-color = mkLiteral "@bg";
        children = map mkLiteral [ "element-icon" "element-text" ];
        spacing = mkLiteral "10px";
      };

      "element selected" = {
        background-color = mkLiteral "@fg";
        text-color = mkLiteral "@bg";
      };

      "element-icon" = { size = mkLiteral "1em"; };

      "element-text, element-icon" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
    };

  };
}
