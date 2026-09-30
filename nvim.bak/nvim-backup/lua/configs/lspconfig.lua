local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require "lspconfig"

-- Add hover capability explicitly
-- capabilities.textDocument.hover = {
--     dynamicRegistration = true,
--     contentFormat = { "markdown", "plaintext" }
-- }

-- TypeScript configuration
lspconfig.ts_ls.setup {
    capabilities = capabilities,
    -- init_options = {
    --     hostInfo = "neovim",
    --     preferences = {
    --         includeCompletionsForImportStatements = true,
    --         includeCompletionsWithSnippetText = true,
    --         includeAutomaticOptionalChainCompletions = true,
    --         includeCompletionsWithClassMemberSnippets = true,
    --         includeCompletionsWithObjectLiteralMethodSnippets = true,
    --         allowIncompleteCompletions = true,
    --         importModuleSpecifierPreference = "relative",
    --         jsxAttributeCompletionStyle = "auto",
    --         provideRefactorNotApplicableReason = true,
    --         allowRenameOfImportPath = true,
    --         includePackageJsonAutoImports = "auto",
    --         quotePreference = "auto",
    --     },
    -- },
    -- flags = {
    --     debounce_text_changes = 150,
    --     allow_incremental_sync = false,
    -- },
    root_dir = require('lspconfig.util').root_pattern('tsconfig.json', 'package.json', '.git'),
    -- settings = {
    --     typescript = {
    --         inlayHints = {
    --             includeInlayParameterNameHints = "all",
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = true,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --         },
    --         suggest = {
    --             completeFunctionCalls = true,
    --         },
    --         updateImportsOnFileMove = {
    --             enabled = "always",
    --         },
    --         format = {
    --             enable = true,
    --         },
    --     },
    --     javascript = {
    --         inlayHints = {
    --             includeInlayParameterNameHints = "all",
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = true,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --         },
    --         suggest = {
    --             completeFunctionCalls = true,
    --         },
    --         updateImportsOnFileMove = {
    --             enabled = "always",
    --         },
    --         format = {
    --             enable = true,
    --         },
    --     },
    -- },
    -- handlers = {
    --     ["textDocument/hover"] = vim.lsp.with(
    --         vim.lsp.handlers.hover,
    --         {
    --             border = "rounded",
    --             focusable = true,
    --             max_width = 80,
    --             max_height = 30,
    --             title = "Hover",
    --             title_pos = "center",
    --         }
    --     ),
    -- },
}

-- Configure other language servers
local servers = { 
    "eslint",
    "html",
    "cssls",
    "stylelint_lsp",
    "jsonls",
    "yamlls",
    "bashls",
    "dockerls"
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        -- flags = {
        --     debounce_text_changes = 150,
        --     allow_incremental_sync = false,
        -- },
    }
end

-- Global LSP settings
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Disable diagnostics in insert mode
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     callback = function()
--         vim.diagnostic.hide()
--     end,
-- })

-- Enable diagnostics when leaving insert mode
-- vim.api.nvim_create_autocmd("InsertLeave", {
--     callback = function()
--         vim.diagnostic.show()
--     end,
-- })

-- https://github.com/neovim/nvim-lspconfig/issues/127
-- delay diagnostics in insert mode
-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--   vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- delay update diagnostics
--     update_in_insert = false,
--   })
