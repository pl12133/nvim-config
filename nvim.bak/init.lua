-- ====
-- Plugins
-- ====
vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },

  -- fuzzy finder
	{ src = 'https://github.com/ibhagwan/fzf-lua' },

  -- Fidget to display lsp info in bottom right
  { src = 'https://github.com/j-hui/fidget.nvim' },

  -- windsurf ai
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/Exafunction/windsurf.nvim' },

  -- rails
  { src = 'https://github.com/tpope/vim-rails' },
}

require('mason').setup()

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {}
        end,

        ['ts_ls'] = function()
          lspconfig.ts_ls.setup {
            init_options = {
              hostInfo = "neovim",
              preferences = {
                includeCompletionsForImportStatements = true,
                includeCompletionsWithSnippetText = true,
                includeAutomaticOptionalChainCompletions = true,
                includeCompletionsWithClassMemberSnippets = true,
                includeCompletionsWithObjectLiteralMethodSnippets = true,
                allowIncompleteCompletions = true,
                importModuleSpecifierPreference = "relative",
                jsxAttributeCompletionStyle = "auto",
                provideRefactorNotApplicableReason = true,
                allowRenameOfImportPath = true,
                includePackageJsonAutoImports = "auto",
                quotePreference = "auto",
              },
            },
            flags = {
              debounce_text_changes = 150,
              allow_incremental_sync = false,
            },
            root_dir = require('lspconfig.util').root_pattern('tsconfig.json', 'package.json', '.git'),
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
                suggest = {
                  completeFunctionCalls = true,
                },
                format = {
                  enable = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
                suggest = {
                  completeFunctionCalls = true,
                },
                updateImportsOnFileMove = {
                  enabled = "always",
                },
                format = {
                  enable = true,
                },
              },
            },
            handlers = {
              ["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                {
                  border = "rounded",
                  focusable = true,
                  max_width = 80,
                  max_height = 30,
                  title = "Hover",
                  title_pos = "center",
                }
              ),
            },
          }
        end,
    },
    ensure_install = {
      "lua-language-server",
      "stylua",
      "typescript-language-server",
      "eslint-lsp",
      "prettier",
      "bash-language-server",
      "css-lsp",
      "html",
    },
    automatic_enable = true,
})

require('mason-tool-installer').setup({
	ensure_install = {
		"lua-language-server",
		"stylua",
		"typescript-language-server",
		"eslint-lsp",
		"prettier",
    "bash-language-server",
    "css-lsp",
    "html",
	}
})

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

require("fidget").setup()

-- FZF Lua
require("fzf-lua").setup({
  { "fzf-vim" },
  actions = {
    files = {
      ["enter"] = require("fzf-lua.actions").file_tabedit,
    },
  },
})

-- Windsurf - unused currently
-- require("codeium").setup({})

-- ====
-- LSP Additional Setup
-- ====
function fixLuaUndefinedVimGlobal ()
	-- source: https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
	vim.lsp.config('lua_ls', {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {
						'vim',
						'require'
					},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},

	})
end

fixLuaUndefinedVimGlobal()

-- ====
-- Options
-- ====
vim.cmd.colorscheme "catppuccin"


-- ====
-- Mappings
-- ====

vim.g.mapleader = 'g'

local map = vim.keymap.set

-- Stuff i havent migrated from my old vimrc file:
vim.cmd [[
  filetype on
  set noincsearch
  highlight LineNr guifg=#eeeeee " set line number color

	set softtabstop=0 tabstop=2 shiftwidth=2 expandtab

	"  Open new tab with FZF File searcher
	let g:fzf_action = { 'enter': 'tabe' }

	nnoremap    <leader>p         :lua FzfLua.files()<CR>
	nnoremap    gb          gT
	nnoremap    g[          gT
	nnoremap    gh          gT
	nnoremap    g]          gt
	nnoremap    gl          gt
	nnoremap    <leader>t   :tabnew<CR>
  
  set relativenumber
  set number
  set hlsearch

  " console.log variable under cursor 
  let @l = 'yeoconsole.log("[FILTERED] p:", p);'

  set path=assets/,.
]]

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

