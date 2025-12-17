{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.formats.rasi) mkLiteral;

  rofi-theme = {
    "*" = {
      red = mkLiteral "rgba ( 220, 50, 47, 100 % )";
      selected-active-foreground = mkLiteral "var(background)";
      lightfg = mkLiteral "rgba ( 88, 104, 117, 100 % )";
      separatorcolor = mkLiteral "rgba ( 255, 255, 255, 100 % )";
      urgent-foreground = mkLiteral "var(red)";
      alternate-urgent-background = mkLiteral "var(lightbg)";
      lightbg = mkLiteral "rgba ( 238, 232, 213, 100 % )";
      background-color = mkLiteral "rgba ( 0, 0, 0, 0 % )";
      border-color = mkLiteral "rgba ( 0, 0, 0, 82 % )";
      normal-background = mkLiteral "rgba ( 0, 0, 0, 0 % )";
      selected-urgent-background = mkLiteral "var(red)";
      alternate-active-background = mkLiteral "var(lightbg)";
      spacing = mkLiteral "2";
      blue = mkLiteral "rgba ( 38, 139, 210, 100 % )";
      alternate-normal-foreground = mkLiteral "var(foreground)";
      urgent-background = mkLiteral "var(background)";
      selected-normal-foreground = mkLiteral "rgba ( 0, 0, 0, 100 % )";
      active-foreground = mkLiteral "var(blue)";
      background = mkLiteral "rgba ( 0, 0, 0, 71 % )";
      selected-active-background = mkLiteral "var(blue)";
      active-background = mkLiteral "var(background)";
      selected-normal-background = mkLiteral "rgba ( 255, 255, 255, 100 % )";
      alternate-normal-background = mkLiteral "rgba ( 255, 255, 255, 0 % )";
      foreground = mkLiteral "rgba ( 255, 255, 255, 100 % )";
      selected-urgent-foreground = mkLiteral "var(background)";
      normal-foreground = mkLiteral "var(foreground)";
      alternate-urgent-foreground = mkLiteral "var(red)";
      alternate-active-foreground = mkLiteral "var(blue)";
    };

    element = {
      padding = mkLiteral "1px";
      spacing = mkLiteral "5px";
      border = mkLiteral "0";
    };

    "element normal.normal" = {
      background-color = mkLiteral "var(normal-background)";
      text-color = mkLiteral "var(normal-foreground)";
    };

    "element normal.urgent" = {
      background-color = mkLiteral "var(urgent-background)";
      text-color = mkLiteral "var(urgent-foreground)";
    };

    "element normal.active" = {
      background-color = mkLiteral "var(active-background)";
      text-color = mkLiteral "var(active-foreground)";
    };

    "element selected.normal" = {
      background-color = mkLiteral "var(selected-normal-background)";
      text-color = mkLiteral "var(selected-normal-foreground)";
    };

    "element selected.urgent" = {
      background-color = mkLiteral "var(selected-urgent-background)";
      text-color = mkLiteral "var(selected-urgent-foreground)";
    };

    "element selected.active" = {
      background-color = mkLiteral "var(selected-active-background)";
      text-color = mkLiteral "var(selected-active-foreground)";
    };

    window = {
      padding = mkLiteral "400 400 350 400";
      background-color = mkLiteral "var(background)";
      border = mkLiteral "1";
      fullscreen = mkLiteral "true";
      width = mkLiteral "100%";
    };

    "listview" = {
      lines = mkLiteral "5"; # show only top 5 options
      padding = mkLiteral "2px 0px 0px";
      scrollbar = mkLiteral "false";
      border-color = mkLiteral "var(separatorcolor)";
      spacing = mkLiteral "2";
      fixed-height = mkLiteral "0";
      border = mkLiteral "2px solid 0px 0px";
    };
  };
in {
  programs.rofi = {
    enable = true;
    theme = rofi-theme;
  };
}
