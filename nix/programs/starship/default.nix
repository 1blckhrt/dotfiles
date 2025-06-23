{
  config,
  pkgs,
  lib,
  ...
}: let
  starshipFormat = "[](#5e81ac)$os[ | ](fg:#2e3440 bg:#5e81ac)$username$hostname[](bg:#81a1c1 fg:#5e81ac)$directory[](bg:#d9dee9 fg:#8fbcbb)$cmd_duration[](fg:#d9dee9)$line_break$character";
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = starshipFormat;
      add_newline = false;

      hostname = {
        style = "fg:#2e3440 bg:#5e81ac";
        format = "[$ssh_symbol$hostname]($style)";
        ssh_only = false;
        ssh_symbol = " ";
      };

      os = {
        style = "fg:#2e3440 bg:#5e81ac";
        disabled = false;
        symbols = {
          Windows = "󰍲";
          Ubuntu = "󰕈";
          SUSE = "";
          Raspbian = "󰐿";
          Mint = "󰣭";
          Macos = "󰀵";
          Manjaro = "";
          Linux = "󰌽";
          Gentoo = "󰣨";
          Fedora = "󰣛";
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CentOS = "";
          Debian = "󰣚";
          Redhat = "󱄛";
          RedHatEnterprise = "󱄛";
          NixOS = "❄️";
        };
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "fg:#2e3440 bg:#5e81ac";
      };

      directory = {
        style = "fg:#2e3440 bg:#81a1c1";
        read_only = " ";
        format = "[ 󰉋 $path ]($style)[$read_only]($read_only_style)";
        read_only_style = "fg:#2e3440 bold bg:#81a1c1";
      };

      sudo = {
        disabled = false;
        symbol = " ";
        style = "fg:#2e3440 bg:#d9dee9";
        format = "[ $symbol]($style)";
      };

      cmd_duration = {
        format = "[ 󰔚 $duration ]($style)";
        style = "fg:#2e3440 bg:#d9dee9";
      };

      character = {
        success_symbol = "[ 󱞩](bold green)";
        error_symbol = "[ 󱞩](bold red)";
        vimcmd_symbol = "[  󱞩](bold green)";
      };
    };
  };
}
