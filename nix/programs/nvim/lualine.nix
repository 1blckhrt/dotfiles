_: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
        theme = "auto";
        globalstatus = true;
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
        disabled_filetypes = ["neo-tree"];
      };

      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch" "diff"];
        lualine_c = ["filename"];
        lualine_x = [
          {
            name = "diagnostics";
            options = {
              sources = ["nvim_diagnostic"];
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = " ";
              };
              cond = ''
                function()
                  return vim.bo.filetype ~= "neo-tree"
                end
              '';
            };
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = ["progress"];
        lualine_z = ["location"];
      };
    };
  };
}
