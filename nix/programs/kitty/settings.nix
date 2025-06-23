{...}: {
  programs.kitty.enable = true;
  programs.kitty.settings = {
    confirm_os_window_close = 0;
    dynamic_background_opacity = true;
    background_blur = 1;
    window_padding_width = 10;
    bold_font = "auto";
    italic_font = "auto";
    cursor_trail = 3;
  };
}
