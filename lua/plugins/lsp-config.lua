return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      ruby_lsp = {
        -- Neovim inherits the global rbenv Ruby (3.1.4), but this project
        -- requires 3.4.8. Without this, ruby-lsp crashes during bundle setup
        -- and never attaches (see ~/.local/state/nvim/lsp.log).
        cmd = function(dispatchers, config)
          return vim.lsp.rpc.start(
            { "bash", "-lc", "rbenv exec ruby-lsp" },
            dispatchers,
            config and config.root_dir and { cwd = config.root_dir }
          )
        end,
      },
    },
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
