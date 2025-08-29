{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
  ];

  programs.nixvim = {
    enable = true;
    plugins.lazy.enable = true;

    viAlias = true;
    vimAlias = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      termguicolors = true;

      smartindent = true;
      softtabstop = 2;
      shiftwidth = 2;
      tabstop = 2;

      swapfile = false;
      backup = false;
      undofile = true;

      hlsearch = false;
      incsearch = true;

      autoread = true;
      wrap = true;
      linebreak = true;
      cursorline = true;
    };

    extraPlugins = [
      pkgs.vimPlugins.lackluster-nvim
    ];

    plugins = {
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
        keymaps = {
          "<leader>sh" = "help_tags";
          "<leader>sk" = "keymaps";
          "<leader><leader>" = "find_files";
          "<leader>ss" = "builtin";
          "<leader>sw" = "grep_string";
          "<leader>sg" = "live_grep";
          "<leader>sd" = "diagnostics";
          "<leader>sr" = "resume";
          "<leader>s." = "oldfiles";
          "<leader>/" = {
            action = "current_buffer_fuzzy_find";
            options.desc = "[/] Fuzzily search in current buffer";
          };
        };
        settings = {
          defaults = {
            prompt_prefix = "   ";
            selection_caret = " ";
            entry_prefix = " ";
            sorting_strategy = "ascending";

            layout_config = {
              horizontal = {
                prompt_position = "top";
                preview_width = 0.55;
              };
              width = 0.87;
              height = 0.80;
            };

            mappings = {
              i = {
                "<C-j>" = "move_selection_next";
                "<C-k>" = "move_selection_previous";
              };
              n = {
                q = "close";
              };
            };
          };
        };
      };

      web-devicons.enable = true;
      nvim-tree.enable = true;
      which-key.enable = true;
      snacks.enable = true;
      render-markdown.enable = true;
      tiny-inline-diagnostic.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };

      treesitter = {
        enable = true;
        ensureInstalled = [
          "python"
          "javascript"
          "typescript"
          "lua"
          "rust"
        ];
      };

      hop.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      barbecue.enable = true;
      neocord.enable = true;
      noice.enable = true;
      notify.enable = true;
      tmux-navigator.enable = true;

      obsidian = {
        enable = true;
        settings = {
          workspaces = [
            {
              name = "main";
              path = "~/Documents/Notes/";
            }
          ];
        };
      };
    };

    keymaps = [
      {
        mode = ["n"];
        key = ";";
        action = ":";
        options = {
          noremap = true;
        };
      }
      {
        mode = ["n"];
        key = "<CR>";
        action = "<cmd>lua require('hop').hint_words()<CR>";
        options = {
          silent = true;
          desc = "Hop to word";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>f";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          silent = true;
          desc = "Format";
        };
      }
      {
        mode = ["n"];
        key = "<C-n>";
        action = ":NvimTreeToggle<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = ["n"];
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle NvimTree";
        };
      }
    ];

    extraConfigLua = ''
      vim.cmd("colorscheme lackluster")
    '';
  };
}
