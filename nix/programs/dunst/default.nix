{
  config,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        transparency = 0;
        frame_width = 2;
        separator_height = 2;
        padding = 8;
        default_timeout = 7;
        max_icon_size = 32;
        monitor = "primary";
        startup_notification = false;
        font = "JetBrainsMono Nerd Font 12";
        format = "<b>%s</b>\n%s";
        sort = true;
        indicateHidden = true;
        stackDuplicates = true;
        hideDuplicateCount = true;
        showAgeThreshold = 60;
        origin = "top-right";
        width = 300;
        height = 80;
        frame_color = "#FFFFFF";
      };
    };
  };
}
