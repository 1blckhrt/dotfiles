{
  config,
  pkgs,
  ...
}: let
  tmuxConf = "${config.home.homeDirectory}/dot/dotfiles/tmux";
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  xdg.configFile."tmux".source = mkSymlink tmuxConf;
  home.packages = with pkgs; [
    tmux
    tmuxp
  ];
}
