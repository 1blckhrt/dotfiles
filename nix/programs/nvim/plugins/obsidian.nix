{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    obsidian = {
      enable = true;
      lazyLoad = {
        settings = {
          ft = "markdown";
          workspaces = [
            {
              name = "main";
              path = "~/Documents/Notes/";
            }
          ];
        };
      };
    };
  };
}
