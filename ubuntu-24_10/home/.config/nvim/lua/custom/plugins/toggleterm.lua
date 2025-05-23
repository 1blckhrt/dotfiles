return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 20,
    open_mapping = [[<C-t>]], -- Ctrl+t for toggle terminal
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float', -- Set floating terminal as the default
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'curved', -- Options: single, double, shadow, curved, etc.
      winblend = 3,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
  },
  vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true, desc = 'Open Terminal' }),
}
