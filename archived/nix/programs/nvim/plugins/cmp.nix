{
  programs.nixvim = {
    plugins = {
      blink-cmp = {
        enable = true;

        settings = {
          keymap = {
            preset = "default";
            "<CR>" = ["accept" "fallback"];
            "<C><leader>" = ["show"];
          };

          appearance = {
            nerd_font_variant = "mono";
          };

          completion = {
            documentation = {
              auto_show = true;
            };
            ghost_text.enabled = true;
          };

          sources = {
            default = ["lsp" "path" "snippets" "buffer"];
          };
        };
      };

      luasnip = {
        enable = true;
        fromVscode = [{}];
      };

      friendly-snippets.enable = true;
    };
  };
}
