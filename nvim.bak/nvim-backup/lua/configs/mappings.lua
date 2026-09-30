local map = vim.keymap.set

-- Simplified diagnostic refresh that doesn't interfere with LSP sync
local function refresh_diagnostics()
    vim.cmd('LspRestart')
end

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- map("n", "<leader>fm", function()
--   require("conform").format { lsp_fallback = true }
-- end, { desc = "general format file" })
map("n", "<leader>fm", '!prettier -w %', { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>dr", refresh_diagnostics, { desc = "restart LSP servers" })

-- tabufline
map("n", "<leader>b", "<cmd>tabe<CR>", { desc = "buffer new" })

-- Comment
-- map("n", "<leader>c", "gcc", { desc = "toggle comment", remap = true })
-- map("v", "<leader>c", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- lsp keybinds
map("n", "[g", vim.diagnostic.goto_prev)
map("n", "]g", vim.diagnostic.goto_next)
map("n", 'gb', '<Nop>')
map('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', {})

map('n', 'gi', vim.lsp.buf.implementation, {})
map('n', 'K', function()
    vim.lsp.buf.hover({
        border = "rounded",
        focusable = true,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        max_width = 80,
        max_height = 30,
        title = "Hover",
        title_pos = "center",
    })
end, {})
map('n', '<leader>b', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

-- luasnip
local ls = require("luasnip")

map({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
map({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
map({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

map({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})