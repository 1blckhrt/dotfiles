local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", "<C-s>", "<cmd>w<CR>", { desc = "save file (normal mode)" })
map("i", "<C-s>", "<cmd>w<CR>", { desc = "save file (insert mode)" })
map("n", ";", ":", opts)
