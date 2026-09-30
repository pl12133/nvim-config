-- Set up nvim-cmp.
local cmp = require'cmp'
local luasnip = require('luasnip')

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Helper function for delayed execution
local function delay(fn, time)
    local timer = vim.loop.new_timer()
    timer:start(time, 0, vim.schedule_wrap(function()
        fn()
        timer:stop()
    end))
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Add performance settings to help with rendering
  performance = {
    debounce = 60,
    throttle = 30,
    fetching_timeout = 500,
    confirm_resolve_timeout = 80,
    async_budget = 1,
    max_view_entries = 200,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- If completion menu is visible, confirm selection
        cmp.confirm({ select = true })
      elseif luasnip.expand_or_jumpable() then
        -- If snippet is available, expand or jump
        luasnip.expand_or_jump()
      else
        -- Otherwise, let Copilot handle it
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- Add arrow key mappings
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Left>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.close()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Right>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'buffer' },
    {
      name = 'path',
      option = {
        trailing_slash = true,
      },
    },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', vim_item.kind, entry:get_completion_item().detail or '')
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
  experimental = {
    ghost_text = true,
  },
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Alternative: If whitespace issues persist, you can disable command line completion:
-- Comment out the cmdline setup sections below to troubleshoot
-- cmp.setup.cmdline({ '/', '?' }, {
--   enabled = false
-- })

-- Command line completion configuration
local cmd_mapping = cmp.mapping.preset.cmdline()
local cmd_mapping_override = {
  ['<Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        local text = vim.fn.getcmdline()
        local expanded = vim.fn.expandcmd(text)
        if expanded ~= text then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, true, true) .. expanded, "n", false)
          -- triggering right away won't work, need to wait a cycle
          delay(cmp.complete, 0)
        else
          cmp.complete()
        end
      end
    end,
  },
  ['<S-Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        local text = vim.fn.getcmdline()
        local expanded = vim.fn.expandcmd(text)
        if expanded ~= text then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, true, true) .. expanded, "n", false)
          -- triggering right away won't work, need to wait a cycle
          delay(cmp.complete, 0)
        else
          cmp.complete()
        end
      end
    end
  }
}

-- Merge the override mappings with the default ones
for k, v in pairs(cmd_mapping_override) do
  cmd_mapping[k] = v
end

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmd_mapping,
    sources = cmp.config.sources({
        {
          name = 'path',
          option = {
            trailing_slash = true,
          },
        }
    }, {
        {
          name = 'cmdline',
          option = {
            treat_trailing_slash = false,
          }
        }
    }),
    -- Add window configuration to prevent rendering issues
    window = {
        completion = {
            border = 'rounded',
            scrollbar = false,
        },
    },
    -- debug formatting to show source
    -- formatting = {
    --     format = function(entry, vim_item)
    --         vim_item.menu = '[' .. entry.source.name .. ']'
    --         return vim_item
    --     end
    -- }
})
