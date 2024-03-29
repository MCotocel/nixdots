{
  programs.ncmpcpp = {
    enable = true;
    settings = {

      mpd_host = "127.0.0.1";
      mpd_port = "6600";

      # Visualizer
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_look = "||";
      visualizer_color = "white";

      autocenter_mode = "yes";
      centered_cursor = "yes";
      ignore_leading_the = "yes";
      allow_for_physical_item_deletion = "no";

      # Appearance;
      colors_enabled = "yes";
      playlist_display_mode = "columns";
      user_interface = "alternative";
      volume_color = "white";

      # Window;
      song_window_title_format = "Music";
      statusbar_visibility = "no";
      header_visibility = "no";
      titles_visibility = "no";
      #startup_slave_screen = "visualizer";

      # Progress bar;
      progressbar_look = "▂▂▂";
      progressbar_color = "black";
      progressbar_elapsed_color = "cyan";

      # Alternative UI;
      alternative_ui_separator_color = "black";
      alternative_header_first_line_format =
        "$b$5«$/b$5« $b$8{%t}|{%f}$/b $5»$b$5»$/b";
      alternative_header_second_line_format =
        "{$b{$2%a$9}{ - $7%b$9}{ ($2%y$9)}}|{%D}";

      # Song list;
      song_status_format = "$7%t";
      song_list_format = "  %t $R%a %l  ";
      song_columns_list_format = "(53)[white]{tr} (45)[blue]{a}";
      song_library_format = "{{%a- %t} (%b)}|{%f}";

      # Colors;
      main_window_color = "white";
      current_item_prefix = "-> ";
      current_item_suffix = " <-";
      current_item_inactive_column_prefix = "- ";
      current_item_inactive_column_suffix = " -";

      color1 = "white";
      color2 = "white";

      lyrics_fetchers = "musixmatch";
    };
  };
}
