{
  config,
  pkgs,
  ...
}: let
  mod = config.xsession.windowManager.i3.config.modifier;
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        bars = [];

        modifier = "Mod4";

        fonts = {
          names = ["JetBrainsMono NF"];
          size = 12.0;
        };

        keybindings = {
          "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${mod}+q" = "kill";
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          # Focus
          "${mod}+j" = "focus left";
          "${mod}+k" = "focus down";
          "${mod}+l" = "focus up";
          "${mod}+semicolon" = "focus right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # Move windows
          "${mod}+Shift+j" = "move left";
          "${mod}+Shift+k" = "move down";
          "${mod}+Shift+l" = "move up";
          "${mod}+Shift+semicolon" = "move right";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # Splitting
          "${mod}+h" = "split h";
          "${mod}+v" = "split v";

          # Fullscreen
          "${mod}+f" = "fullscreen toggle";

          # Floating
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          # Workspaces
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          # Configuration
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "exec i3-msg restart; notify-send 'i3 has been refreshed.'";
          "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit' 'i3-msg exit'";

          # Media keys
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

          # Screenshots
          "Print" = "exec flameshot";

          # Workspace navigation
          "${mod}+Tab" = "workspace next";
          "${mod}+Shift+Tab" = "workspace prev";

          # Dunst restart
          "${mod}+Shift+d" = "--release exec killall dunst; exec notify-send 'restart dunst'";
        };

        window = {
          border = 5;
          commands = [
            {
              command = "border pixel 5";
              criteria = {class = "^.*";};
            }
          ];
        };

        floating = {modifier = "Mod4";};

        gaps = {inner = 12;};

        colors = {
          focused = {
            border = "#FFFFFF";
            background = "#FFFFFF";
            text = "#FFFFFF";
            indicator = "#FFFFFF";
            childBorder = "#FFFFFF";
          };
          focusedInactive = {
            border = "#888888";
            background = "#888888";
            text = "#888888";
            indicator = "#888888";
            childBorder = "#888888";
          };
          unfocused = {
            border = "#888888";
            background = "#888888";
            text = "#888888";
            indicator = "#888888";
            childBorder = "#888888";
          };
          urgent = {
            border = "#888888";
            background = "#888888";
            text = "#888888";
            indicator = "#888888";
            childBorder = "#888888";
          };
          placeholder = {
            border = "#000000";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#000000";
            childBorder = "#000000";
          };
        };

        startup = [
          {
            command = "i3-msg 'log_level debug'";
            always = true;
            notification = false;
          }
          {
            command = "dex --autostart --environment i3";
            always = true;
            notification = false;
          }
          {
            command = "~/.config/i3/scripts/restart-picom.sh";
            always = true;
            notification = false;
          }
          {
            command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart picom.service";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart xdg-desktop-portal.service";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
          {
            command = "dunst";
            always = true;
            notification = true;
          }
          {
            command = "~/.config/i3/scripts/autotile.py";
            always = true;
            notification = false;
          }
          {
            command = "~/.config/i3/scripts/monitors.sh";
            always = true;
            notification = false;
          }
        ];
      };

      extraConfig = ''
        tiling_drag modifier titlebar
      '';
    };
  };

  services.picom = {
    enable = true;
    backend = "xrender";
    vSync = true;
    shadow = true;
    fade = true;
    fadeSteps = [0.03 0.03];
    inactiveOpacity = 0.9;
    activeOpacity = 1.0;
    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        opacity = 0.85;
        focus = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 0.9;};
      dropdown_menu = {opacity = 0.9;};
    };
  };

  home.packages = with pkgs; [
    rofi
    pulseaudio
    flameshot
    dex
    xss-lock
    i3lock
    networkmanagerapplet
    dunst
    libnotify
    polybar
    libappindicator-gtk3
    libayatana-appindicator
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];

  services.polybar = {
    enable = true;
    script = "polybar -q -r main &";
    config = {
      "bar/main" = {
        monitor = "eDP-1";
        width = "100%";
        height = "30px";

        background = "#000000";
        foreground = "#FFFFFF";
        modules-left = "i3";
        modules-center = "xwindow";
        modules-right = "date battery tray";
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        format = "<label>";
        foreground = "#FFFFFF";
        format-padding = 1;
        label = "%title%";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";

        ws-icon-0 = "1:1";
        ws-icon-1 = "2:2";
        ws-icon-2 = "3:3";
        ws-icon-3 = "4:4";
        ws-icon-4 = "5:5";

        label-mode = "%mode%";
        label-mode-padding = 2;

        label-unfocused = "%icon%";
        label-unfocused-padding = 1;

        label-focused = "%index% %icon%";
        label-focused-font = 2;
        label-focused-padding = 1;

        label-visible = "%icon%";
        label-visible-padding = 1;

        label-urgent = "%index%";
        label-urgent-padding = 1;

        label-separator = "";
      };

      "module/date" = {
        type = "internal/date";
        interval = "1.0";
        time = "%H:%M:%S";
        time-alt = "%Y-%m-%d%";
        format = "<label>";
        format-padding = 4;
        label = "%time%";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        full-at = 98;
        label-charging = "⚡ %percentage%";
        label-discharging = " %percentage%";
        label-full = " %percentage%";
      };

      "module/tray" = {
        type = "internal/tray";
        tray-foreground = "#FFFFFF";
      };
    };
  };

  home.file.".config/i3/scripts/autotile.py".source = ./scripts/autotile.py;
  home.file.".config/i3/scripts/monitors.sh".source = ./scripts/monitors.sh;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
