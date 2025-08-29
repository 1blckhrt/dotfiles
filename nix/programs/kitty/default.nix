{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    environment = {
      KITTY_DISABLE_OPENGLES = "1";
    };
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      background_blur = 1;
      window_padding_width = 10;
      bold_font = "auto";
      italic_font = "auto";
      mouse_hide_wait = 0;
      # cursor_trail = 3;
    };
    font = {
      name = "Adwaita Mono Nerd Font";
      size = 12;
    };
  };
}
