{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # snixembed bridge for trayscale support
  services.snixembed = {
    enable = true;
    beforeUnits = ["polybar.service" "trayscale.service"];
  };
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
    };

    script = ''
      polybar -q -r main &
      polybar -q -r main2 &
    '';

    config = {
      "bar/main" = {
        monitor = "eDP-1";
        width = "100%";
        height = "30px";
        scroll-up = "#i3.prev";
        scroll-down = "#i3.next";
        border-size = 4;
        border-color = "#FFFFFF";
        font-0 = "JetBrainsMono NF:size=12;1";
        font-1 = "Font Awesome 6 Free Solid:size=12;1";
        background = "#000000";
        foreground = "#FFFFFF";
        separator = " | ";
        modules-left = "distro-icon i3 ";
        modules-center = "xwindow";
        modules-right = "date battery tray";
      };
      "bar/main2" = {
        monitor = "HDMI-1";
        width = "100%";
        height = "30px";
        scroll-up = "#i3.prev";
        scroll-down = "#i3.next";
        border-size = 4;
        border-color = "#FFFFFF";
        font-0 = "JetBrainsMono NF:size=12;1";
        font-1 = "Font Awesome 6 Free Solid:size=12;1";
        background = "#000000";
        foreground = "#FFFFFF";
        separator = " | ";
        modules-left = "distro-icon i3 ";
        modules-center = "xwindow";
        modules-right = "date battery";
      };

      "module/distro-icon" = {
        type = "custom/script";
        exec = "echo 󰣭";
        interval = 99999;
        format = "<label>";
        foreground = "#FFFFFF";
        label = "%output%";
        format-padding = 4;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        format = "<label>";
        foreground = "#FFFFFF";
        label = "%title%";
        label-maxlen = 70;
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        foreground = "#FFFFFF";
        label-mode = "%mode%";
        label-focused = "  %name% ";
        label-unfocused = "  %name% ";
        label-visible = "  %name% ";
        label-urgent = "  %name% ";
        format-padding = 4;
      };

      "module/date" = {
        type = "internal/date";
        interval = "1.0";
        time = "%H:%M:%S";
        time-alt = "%Y-%m-%d%";
        format = "<label>";
        label = " %time%";
        format-padding = 4;
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        full-at = 98;
        label-charging = " %percentage%";
        label-discharging = " %percentage%";
        label-full = " %percentage%";
        format-padding = 4;
      };

      "module/tray" = {
        type = "internal/tray";
        tray-foreground = "#000000";
        tray-background = "#FFFFFF";
        format-padding = 4;
      };
    };
  };
}
