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
  programs.nixvim.enable = true;

  programs.nixvim.plugins.lazy.enable = true;

  programs.nixvim = {
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

    colorschemes.nightfox = {
      enable = true;
      flavor = "carbonfox";
    };

    plugins = {
      web-devicons.enable = true;
      neo-tree.enable = true;
      which-key.enable = true;
      treesitter = {
        enable = true;
        settings.ensure_installed = ["python" "javascript" "typescript" "lua"];
      };
      hop.enable = true;
      snacks.enable = true;
      trouble.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      barbecue.enable = true;
      telescope.enable = true;
      neocord.enable = true;
      noice.enable = true;
      neogit.enable = true;
      tiny-inline-diagnostic.enable = true;
      project-nvim.enable = true;
      vim-suda.enable = true;
      notify.enable = true;
      toggleterm.enable = true;
      render-markdown.enable = true;
      alpha = {
        enable = true;
        theme = "dashboard";
      };
      obsidian = {
        enable = true;
        settings.dir = "~/blckhrt_home/doc/notes";
        settings.ui.enable = false;
      };
    };

    keymaps = [
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
        mode = ["n"];
        key = "<leader>p";
        action = "<cmd>lua require('telescope').extensions.projects.projects({})<CR>";
        options = {
          silent = true;
          desc = "Pick a project";
        };
      }
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
        key = "<C-t>";
        mode = ["n" "x" "o"];
        action = ":ToggleTerm direction=float size=0.5<CR>";
        options.desc = "Open Toggle Term";
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
        action = ":Neogit kind=auto<CR>";
        key = "<leader>g";
        mode = "n";
        options.desc = "Git for Neovim";
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
    ];

    extraConfigLua = ''
            vim.diagnostic.config({
              virtual_text = false
            })
         require('telescope').load_extension('projects')

      vim.keymap.set({"n", "v"}, ";", ":", { noremap = true })
    '';
  };
}
