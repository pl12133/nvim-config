-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- buf movement
map("n", "<leader>[", "<cmd>bprev<CR>", { desc = "Previous Buffer" })
map("n", "<leader>h", "<cmd>bprev<CR>", { desc = "Previous Buffer" })
map("n", "<leader>]", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>l", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>t", "<cmd>enew<CR>", { desc = "New Buffer" })

-- Close the current buffer and move to the previous one
-- This replicates the idea of closing a tab
-- map("n", "<leader>bq", ":bp <BAR> bd #<CR>", { desc = "Delete Buffer" })

-- lsp stuff
map("n", "[g", vim.diagnostic.goto_prev)
map("n", "]g", vim.diagnostic.goto_next)

-- you should try to use <leader>ff instead but this is old muscle memory
map("n", "<leader>p", Snacks.picker.files)

-- Remove persist of visual mode after indentation
map("v", "<", "<", { desc = "Indent Left" })
map("v", ">", ">", { desc = "Indent Right" })

-- move flash to <leader>fs
vim.keymap.del("n", "s")
map("n", "<leader>fs", '<cmd>lua require("flash").jump()<cr>')
