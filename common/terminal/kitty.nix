{
  config,
  pkgs,
  ...
}: let
  kittyConf = "${config.home.homeDirectory}/dot/dotfiles/kitty";
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."kitty".source = mkSymlink kittyConf;
  home.packages = with pkgs; [
    kitty
  ];
}
