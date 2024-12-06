{ config, pkgs, ... }: {

  programs.git = {
    enable = true;
    userName = "1blckhrt";
    userEmail = "williams.1691@wright.edu";
    aliases = {
      st = "status";
    };
    extraConfig = {
      help = { autocorrect = 50; };
    };
  };
}