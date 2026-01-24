{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    wl-clipboard
    libnotify
    wmenu
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    xwayland = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = rec {
      modifier = "Mod1";
      window = {
        border = 4;
        titlebar = false;
      };
      terminal = "${pkgs.kitty}/bin/kitty";
      gaps.inner = 20;
      focus.followMouse = true;
      startup = [{command = "--no-startup-id '${lib.getExe pkgs.swayalt}'";}];
      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessDown" = "exec 'brightnessctl s 5%-'";
        "XF86MonBrightnessUp" = "exec 'brightnessctl s 5%+'";
        "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +2%'";
        "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -2%'";
        "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        "${modifier}+Shift+e" = "exec 'swaymsg exit'";
        "${modifier}+d" = "exec '${lib.getExe pkgs.wmenu "wmenu-run"}'";
      };
    };
  };

  programs.i3status-rust = {
    enable = true;
  };
}
