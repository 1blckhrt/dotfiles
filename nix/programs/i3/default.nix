{
  config,
  pkgs,
  ...
}: let
  modifier = "Mod4";
  cfg = config.xsession.windowManager.i3;
in {
  home.packages = with pkgs; [
    lightlocker
    nerdfonts # Fonts utilised by rofi-power-menu
    rofi
    dmenu
    scrot
    xpad
  ];

  # i3 configuration
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = "${modifier}";
      menu = "rofi -show drun";
      terminal = "kitty";

      fonts = {
        names = ["pango:monospace"];
        size = 8.0;
      };

      keybindings = {
        "${modifier}+Return" = "exec ${cfg.config.terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = ''exec "${cfg.config.menu}"'';
        "${modifier}+Shift+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "Mod1+Tab" = "focus right";
        "Mod1+Shift+Tab" = "focus left";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+Control+Left" = "move container to output left";
        "${modifier}+Control+Down" = "move container to output down";
        "${modifier}+Control+Up" = "move container to output up";
        "${modifier}+Control+Right" = "move container to output right";

        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+a" = "focus parent";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Switch to workspace
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        "${modifier}+F1" = "workspace number 11";
        "${modifier}+F2" = "workspace number 12";
        "${modifier}+F3" = "workspace number 13";
        "${modifier}+F4" = "workspace number 14";
        "${modifier}+F5" = "workspace number 15";
        "${modifier}+F6" = "workspace number 16";
        "${modifier}+F7" = "workspace number 17";
        "${modifier}+F8" = "workspace number 18";
        "${modifier}+F9" = "workspace number 19";
        "${modifier}+F10" = "workspace number 20";
        "${modifier}+F11" = "workspace number 21";
        "${modifier}+F12" = "workspace number 22";

        # Move focused container to workspace
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        "${modifier}+Shift+F1" = "move container to workspace number 11";
        "${modifier}+Shift+F2" = "move container to workspace number 12";
        "${modifier}+Shift+F3" = "move container to workspace number 13";
        "${modifier}+Shift+F4" = "move container to workspace number 14";
        "${modifier}+Shift+F5" = "move container to workspace number 15";
        "${modifier}+Shift+F6" = "move container to workspace number 16";
        "${modifier}+Shift+F7" = "move container to workspace number 17";
        "${modifier}+Shift+F8" = "move container to workspace number 18";
        "${modifier}+Shift+F9" = "move container to workspace number 19";
        "${modifier}+Shift+F10" = "move container to workspace number 20";
        "${modifier}+Shift+F11" = "move container to workspace number 21";
        "${modifier}+Shift+F12" = "move container to workspace number 22";

        # Move workspaces between outputs
        "${modifier}+Control+Shift+Left" = "move workspace to output left";
        "${modifier}+Control+Shift+Down" = "move workspace to output down";
        "${modifier}+Control+Shift+Up" = "move workspace to output up";
        "${modifier}+Control+Shift+Right" = "move workspace to output right";

        # i3 management
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        # Mode selection
        "${modifier}+r" = "mode resize";

        # Move workspaces between displays

        # Tab between workspaces
        "${modifier}+Tab" = "workspace next_on_output";
        "${modifier}+Shift+Tab" = "workspace prev_on_output";

        # Pulse Audio controls
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

        # Screen brightness controls
        "XF86MonBrightnessUp" = "exec xbacklight -inc 10";
        "XF86MonBrightnessDown" = "exec xbacklight -dec 10";

        # Media player controls
        "XF86AudioPlay" = "exec playerctl play";
        "XF86AudioPause" = "exec playerctl pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # Lock Screen
        "${modifier}+l" = "exec --no-startup-id ${pkgs.lightlocker}/bin/light-locker-command --lock";

        # The middle button over a titlebar kills the window
        "--release button2" = "kill";
        # The middle button and a modifer over any part of the window kills the window
        "--whole-window ${modifier}+button2" = "kill";

        # Keybindings for the scrot, screenshotting software.
        # Using --release so that scrot can capture the mouse
        # Printscreen screenshots of active window
        "--release Print" = "exec ${pkgs.scrot}/bin/scrot -u ~/images/scrots/'%Y-%m-%d-%H%M%S_$wx$h.png'";
        # Printscreen of whole screen
        "--release Control+Print" = "exec ${pkgs.scrot}/bin/scrot ~/images/scrots/'%Y-%m-%d-%H%M%S_$wx$h.png'";
        # Printscreen of selection
        "--release Shift+Print" = "exec ${pkgs.scrot}/bin/scrot -s ~/images/scrots/'%Y-%m-%d-%H%M%S_$wx$h.png'";

        # Power Controls
        "Control+Mod1+Delete" =
          ''exec "rofi -show p ''
          + "-modi 'p:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot/hibernate/lockscreen/logout' "
          + ''-theme-str 'window {width: 20em;} listview {lines: 6;}'"'';

        # Open notes
        "${modifier}+n" = "exec ${pkgs.xpad}/bin/xpad";
        # Create a new note
        "${modifier}+Shift+n" = "exec ${pkgs.xpad}/bin/xpad -n";
        # Toggle showing and hiding notes
        "${modifier}+Control+n" = "exec ${pkgs.xpad}/bin/xpad -t";
      };

      startup = [
        {
          command = "${pkgs.lightlocker}/bin/light-locker";
          notification = false;
          always = true;
        }
        {
          command = "nm-applet";
          notification = false;
        }
      ];

      modes = {
        resize = {
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Shift+Left" = "resize shrink width 1 px or 1 ppt";
          "Shift+Down" = "resize grow height 1 px or 1 ppt";
          "Shift+Up" = "resize shrink height 1 px or 1 ppt";
          "Shift+Right" = "resize grow width 1 px or 1 ppt";
          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };
    };
  };
}
