{
  config,
  pkgs,
  inputs,
  lib,
  nixGL,
  ...
}: {
  programs.alacritty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.alacritty;

    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };

      colors.primary = {
        background = "#000000"; # black
        foreground = "#ffffff"; # white
      };

      font = {
        size = 8.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
      };
    };
  };
}
