local break_on_exceptions = false

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "suketa/nvim-dap-ruby",
    "rcarriga/nvim-dap-ui",
  },
  keys = {
    {
      -- Detach only. <leader>dt (terminate) makes rdbg exit the whole server.
      "<leader>dD",
      function()
        require("dap").disconnect({ terminateDebuggee = false })
        require("dap").close()
      end,
      desc = "Disconnect (keep server running)",
    },
    {
      "<leader>df",
      function()
        require("dap").focus_frame()
      end,
      desc = "Jump to current frame",
    },
    {
      -- Toggle rdbg's "rescue any exception" filter; also applies to new sessions.
      "<leader>dE",
      function()
        local dap = require("dap")
        break_on_exceptions = not break_on_exceptions
        local filters = break_on_exceptions and { "any" } or {}
        dap.defaults.ruby.exception_breakpoints = filters
        if dap.session() then
          dap.set_exception_breakpoints(filters)
        end
        vim.notify("Break on exceptions: " .. (break_on_exceptions and "any" or "none"))
      end,
      desc = "Toggle break on exceptions",
    },
  },
  config = function()
    local dap = require("dap")
    -- dapui.setup() is done by LazyVim's dap.core extra
    require("dap-ruby").setup()

    table.insert(dap.configurations.ruby, {
      name = "attach existing (port 38698) (no localfs)",
      type = "ruby",
      request = "attach",
      options = { source_filetype = "ruby" },
      error_on_failure = true,
      localfs = false,
      port = 38698,
    })

    -- Docker: path map comes from RUBY_DEBUG_LOCAL_FS_MAP (remote:local) on the server.
    -- localfs must be false, or the server ignores that map.
    table.insert(dap.configurations.ruby, {
      name = "attach docker vd-ui (port 38698)",
      type = "ruby",
      request = "attach",
      options = { source_filetype = "ruby" },
      error_on_failure = true,
      localfs = false,
      host = "127.0.0.1",
      port = 38698,
      waiting = 0,
    })
  end,
}
