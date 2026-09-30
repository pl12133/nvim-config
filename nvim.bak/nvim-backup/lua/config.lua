-- CopilotChat configuration
require("CopilotChat").setup {
    -- See Configuration section for options
}

-- Load all configurations
require("./configs/fidget")
require("./configs/mappings")
require("./configs/nvim-cmp")
-- require("./configs/conform")
-- require("./configs/luasnip")
-- require("./configs/tree-sitter")
require("./configs/lspconfig")
-- require("./configs/builtin-compl") -- Disabled to avoid conflict with nvim-cmp

-- Status line configuration
require('lualine').setup({
    options = {
        theme = 'catppuccin',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
})

-- Most manual way!
-- vim.lsp.start({
--   name = 'my-ts-ls',
--   cmd = {'typescript-language-server', '--stdio'},
--   root_dir = vim.fs.dirname(vim.fs.find({'tsconfig.json', 'package.json'}, { upward = true })[1]),
-- })

-- require("./configs/nvim-cmp") -- turn this off to see if it fixes screen tearing
-- require("./configs/lsp-status")
