return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = { eslint = {} },
    setup = {
      eslint = function()
        require("snacks.util.lsp").on(function(_, client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "vtsls" or client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
    --     vtsls = {
    --       settings = {
    --         typescript = {
    --           enabled = false,
    --           format = {
    --             -- Configure TypeScript formatter to match your ESLint rules
    --             semicolons = "always", -- Matches your ESLint rule
    --             indentSize = 4,
    --             insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
    --           },
    --         },
    --         javascript = {
    --           enabled = false,
    --           format = {
    --             semicolons = "always", -- Matches your ESLint rule
    --             indentSize = 4,
    --             insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
