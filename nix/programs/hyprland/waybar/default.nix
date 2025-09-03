{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  custom = {
    font = "JetBrainsMono Nerd Font";
    font_size = "15px";
    font_weight = "normal";
    text_color = "#ffffff";
    background_0 = "#000000";
    background_1 = "#111111";
    border_color = "#444444";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    opacity = "0.95";
    indicator_height = "2px";
  };
in {
  home.packages = with pkgs; [
    networkmanagerapplet
    snixembed
    libappindicator-gtk3
  ];
  services.snixembed.enable = true;
  programs.waybar.settings = with custom; [
    {
      position = "top";
      layer = "top";
      height = 42;
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      modules-left = [
        "custom/linuxmint"
        "hyprland/workspaces"
      ];
      modules-center = ["hyprland/window"];
      modules-right = [
        "pulseaudio"
        "network"
        "battery"
        "clock"
        "tray"
      ];

      "custom/linuxmint" = {
        format = "  ";
        tooltip = true;
        tooltip-format = "Linux Mint";
      };

      "hyprland/workspaces" = {
        all-outputs = true;
        format = "{icon}";
        format-icons = {
          urgent = "";
          active = "";
          default = "";
        };
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-muted = " {volume}%";
        format-icons = {
          default = [""];
        };
        scroll-step = 2;
        on-click = "pamixer -t";
        on-click-right = "pavucontrol";
      };

      "network" = {
        format-wifi = " {essid} ({signalStrength}%)";
        format-ethernet = "{ipaddr}/{cidr} ";
        tooltip-format = "{ifname} via {gwaddr}";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "Disconnected ⚠";
      };

      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-full = "{icon} {capacity}%";
        format-icons = ["" "" "" "" ""];
      };

      "clock" = {
        format = "{:%H:%M | %e %B}";
        tooltip = true;
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };

      "tray" = {
        icon-size = 16;
        spacing = 4;
      };
    }
  ];

  programs.waybar.style = ''
    * {
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: ${custom.font_size};
      color: ${custom.text_color};
      transition: background-color 0.3s ease-out;
    }

    window#waybar {
      background: rgba(0,0,0,0.95);
      color: ${custom.text_color};
      font-family: "JetBrainsMono Nerd Font", monospace;
      transition: background-color 0.5s;
    }

    .modules-center,
    .modules-left,
    .modules-right {
      background: rgba(0,0,0,0.85);
      margin: 5px 10px;
      padding: 0 5px;
      border-radius: 15px;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #temperature,
    #network,
    #pulseaudio,
    #tray
    {
      padding: 0 10px;
      border-radius: 15px;
    }
  '';
}
