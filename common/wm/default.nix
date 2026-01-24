{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    libnotify
    wmenu
    autotiling-rs
    swaybg
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    xwayland = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = rec {
      modifier = "Mod1";
      bars = [];
      window = {
        border = 4;
        titlebar = false;
      };
      terminal = "${pkgs.kitty}/bin/kitty";
      gaps.inner = 20;
      focus.followMouse = true;
      startup = [
        {command = "--no-startup-id ${pkgs.autotiling-rs}/bin/autotiling-rs";}
        {command = "--no-startup-id ${pkgs.swaybg}/bin/swaybg -i ~/dot/dotfiles/bg.png";}
        {command = "--no-startup-id ${pkgs.i3status-rust}/bin/i3status-rs";} # add config
      ];
      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessDown" = "exec 'brightnessctl s 5%-'";
        "XF86MonBrightnessUp" = "exec 'brightnessctl s 5%+'";
        "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +2%'";
        "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -2%'";
        "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway?' -b 'Yes, exit sway' 'swaymsg exit'";
        "${modifier}+d" = "exec ${pkgs.wmenu}/bin/wmenu-run";
        "${modifier}+q" = "kill";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
      };
    };
    extraConfig = ''
      default_dim_inactive 0.2
      corner_radius 5
    '';
  };

  programs.i3status-rust = {
    enable = true;
  };
}
