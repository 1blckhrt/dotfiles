{ config, pkgs, inputs, ... }:
{
  imports = [
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
    ./neotree.nix
  ];
  programs.nixvim.enable = true;

  programs.nixvim = {
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
      lazyredraw = true;

      wrap = false;
      linebreak = true;
      cursorline = true;
    };

    colorschemes.nord.enable = true;

    plugins = {
      web-devicons.enable = true;
      which-key.enable = true;
      treesitter = {
        enable = true;
        settings.ensure_installed = ["python" "javascript" "typescript" "rust" "lua"];
      };

      rustaceanvim.enable = true;
      snacks.enable = true;
      trouble.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      barbecue.enable = true;
      telescope.enable = true;
      flash.enable = true;
      neocord.enable = true;
      noice.enable = true;
      neogit.enable = true;
      yazi.enable = true;
      tiny-inline-diagnostic.enable = true;
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>f";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          silent = true;
          desc = "Format";
        };
      }
      {
        key = ",";
        mode = ["n" "x" "o"];
        action = ":ToggleTerm direction=float size=0.5<CR>";
        options.desc = "Open Toggle Term";
      }
      {
        key = "ff";
        mode = ["n" "x" "o"];
        action = ''<cmd>lua require("flash").jump()<cr>'';
        options.desc = "Flash";
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options.desc = "LSP Definitions / references / ... (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options.desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options.desc = "Quickfix List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
        options.desc = "[S]earch [H]elp";
      }
      {
        mode = "n";
        key = "<leader>sk";
        action = "<cmd>lua require('telescope.builtin').keymaps()<CR>";
        options.desc = "[S]earch [K]eymaps";
      }
      {
        mode = "n";
        key = "<leader>sf";
        action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
        options.desc = "[S]earch [F]iles";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>lua require('telescope.builtin').builtin()<CR>";
        options.desc = "[S]earch [S]elect Telescope";
      }
      {
        mode = "n";
        key = "<leader>sw";
        action = "<cmd>lua require('telescope.builtin').grep_string()<CR>";
        options.desc = "[S]earch current [W]ord";
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
        options.desc = "[S]earch by [G]rep";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>lua require('telescope.builtin').diagnostics()<CR>";
        options.desc = "[S]earch [D]iagnostics";
      }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>lua require('telescope.builtin').resume()<CR>";
        options.desc = "[S]earch [R]esume";
      }
      {
        mode = "n";
        key = "<leader>s.";
        action = "<cmd>lua require('telescope.builtin').oldfiles()<CR>";
        options.desc = "[S]earch Recent Files";
      }
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = ''
          <cmd>lua require("telescope.builtin").current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
          )<CR>'';
        options.desc = "[/] Fuzzily search in current buffer";
      }
      {
        mode = "n";
        key = "<leader>s/";
        action = ''
          <cmd>lua require("telescope.builtin").live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files"
          })<CR>'';
        options.desc = "[S]earch [/] in Open Files";
      }
      {
        mode = "n";
        key = "<leader>sn";
        action = ''
          <cmd>lua require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("config")
          })<CR>'';
        options.desc = "[S]earch [N]eovim files";
      }
      {
        action = ":Neogit kind=auto<CR>";
        key = "<leader>g";
        mode = "n";
        options.desc = "Magit for Vim";
      }
    ];

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = false
      })
    '';
  };
}
