_: {
  programs.nh = {
    enable = true;
    homeFlake = "/home/blckhrt/dot/";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
