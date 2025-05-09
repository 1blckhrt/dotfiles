return {
  {
    'shaunsingh/nord.nvim',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- Apply the colorscheme directly
      vim.cmd.colorscheme 'nord'
    end,
  },

  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- Ensure `nord` is loaded before configuring bufferline
      local highlights = require('nord').bufferline.highlights {
        italic = true,
        bold = true,
      }

      require('bufferline').setup {
        options = {
          separator_style = 'thin',
        },
        highlights = highlights,
      }
    end,
  },
}
