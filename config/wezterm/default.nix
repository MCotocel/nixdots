{ config, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm';
      
      return {
        front_end = "OpenGL",
        font = wezterm.font('Iosevka NF', { stretch="UltraCondensed", weight="Regular" }),
        font_size = 11,
        colors = {
            foreground = "#d5d5d5",
            background = "#181e23",
            cursor_bg = "#d5d5d5",
            cursor_fg = "#d5d5d5",
            cursor_border = "#d5d5d5",
            selection_fg = "#181e23",
            selection_bg = "#d5d5d5",
            scrollbar_thumb = "#d5d5d5",
            split = "#1f252a",
            ansi = {"#384149", "#ff8080", "#97d59b", "#fffe80", "#80d1ff", "#c780ff", "#ace1ff", "#d5d5d5"},
            brights = {"#384149", "#ff8080", "#97d59b", "#fffe80", "#80d1ff", "#c780ff", "#ace1ff", "#d5d5d5"},
            indexed = {[136] = "#d5d5d5"},
                      },
        window_padding = {
          left = 30,
          right = 30,
          top = 30,
          bottom = 30,
        },
        enable_tab_bar = false,
        show_update_window = false,
        check_for_updates = false,
        default_cursor_style = "BlinkingBar",
        animation_fps = 1,
        cursor_blink_rate = 0,
        scrollback_lines = 7500,
                      }
    '';
  };
}
