{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      scrollback_lines = 10000;

      # Font
      font_family = "Iosevka Nerd Font Mono";
      font_size = 11;
      bold_italic_font = "auto";

      # Window
      window_padding_width = 14;
      window_padding_height = 14;
      hide_window_decorations = "yes";
      show_window_resize_notification = "no";
      confirm_os_window_close = 0;

      # Aesthetics
      cursor_shape = "block";
      enable_audio_bell = "no";

      # Minimal Tab bar styling
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # Theme
      foreground = "#bebebe";
      background = "#121212";
      selection_foreground = "#121212";
      selection_background = "#333333";

      cursor = "#eaeaea";
      cursor_text_color = "#121212";

      url_color = "#bebebe";

      active_border_color = "#595959";
      inactive_border_color = "#595959";
      bell_border_color = "#595959";

      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      active_tab_foreground = "#bebebe";
      active_tab_background = "#121212";
      inactive_tab_foreground = "#bebebe";
      inactive_tab_background = "#121212";
      tab_bar_background = "#bebebe";

      mark1_foreground = "#121212";
      mark1_background = "#404040";
      mark2_foreground = "#121212";
      mark2_background = "#121212";
      mark3_foreground = "#121212";
      mark3_background = "#a6a6a6";

      color0 = "#333333";
      color8 = "#8a8a8d";
      color1 = "#D35F5F";
      color9 = "#B91C1C";
      color2 = "#FFC107";
      color10 = "#FFC107";
      color3 = "#B91C1C";
      color11 = "#b90a0a";
      color4 = "#e68e0d";
      color12 = "#f59e0b";
      color5 = "#D35F5F";
      color13 = "#B91C1C";
      color6 = "#bebebe";
      color14 = "#eaeaea";
      color7 = "#bebebe";
      color15 = "#ffffff";
    };
  };
}
