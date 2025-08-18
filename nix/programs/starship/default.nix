{
  config,
  pkgs,
  lib,
  ...
}: let
  starshipFormat = "[](#000000)$os[ | ](fg:white bg:#000000)$username $hostname[ | ](bg:#000000 fg:white)$directory[ | ](bg:#000000 fg:#d0d0d0)$cmd_duration[ > ](fg:#d0d0d0)";
in {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = starshipFormat;
      add_newline = false;

      hostname = {
        style = "fg:white bg:#000000";
        format = "$hostname";
        ssh_only = false;
      };

      os = {
        style = "fg:white bg:#000000";
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
        format = "$user";
        style_user = "fg:white bg:#000000";
      };

      directory = {
        style = "fg:white bg:#000000";
        read_only = " ";
        format = "[ 󰉋 $path ]($style)[$read_only]($read_only_style)";
        read_only_style = "fg:white bold bg:#000000";
      };

      sudo = {
        disabled = false;
        symbol = " ";
        style = "fg:white bg:#000000";
        format = "[ $symbol]($style)";
      };

      cmd_duration = {
        format = "[ 󰔚 $duration ]($style)";
        style = "fg:white bg:#000000";
      };

      character = {
        success_symbol = "[ 󱞩](bold white)";
        error_symbol = "[ 󱞩](bold white)";
        vimcmd_symbol = "[  󱞩](bold white)";
      };
    };
  };
}
