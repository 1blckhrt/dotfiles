{
  config,
  pkgs,
  ...
}: let
  starshipConf = "${config.home.homeDirectory}/dot/dotfiles/starship/starship.toml";
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."starship.toml".source = mkSymlink starshipConf;
  home.packages = with pkgs; [
    starship
  ];
}
