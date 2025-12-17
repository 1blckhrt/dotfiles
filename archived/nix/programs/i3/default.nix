{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  mod = config.xsession.windowManager.i3.config.modifier;
in {
  imports = [./dunst/default.nix ./rofi/default.nix ./picom/default.nix ./polybar/default.nix ./packages.nix ./monitors.nix];
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
          "${mod}+Return" = "exec --no-startup-id ${pkgs.alacritty}/bin/alacritty";
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
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart xdg-desktop-portal.service";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart dunst.service";
            always = true;
            notification = true;
          }
          {
            command = "systemctl --user restart trayscale.service";
            always = true;
            notification = true;
          }
          {
            command = "systemctl --user restart snixembed.service";
            always = true;
            notification = true;
          }
        ];
      };

      extraConfig = ''
        tiling_drag modifier titlebar
        exec_always --no-startup-id ${pkgs.autotiling}/bin/autotiling
      '';
    };
  };
}
