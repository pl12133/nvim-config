return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "suketa/nvim-dap-ruby",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    require("dapui").setup()
    require("dap-ruby").setup()

    table.insert(dap.configurations.ruby, {
      name = "attach existing (port 38698) (no localfs)",
      type = "ruby",
      request = "attach",
      options = { source_filetype = "ruby" },
      error_on_failure = true,
      localfs = false,
      port = 38698,
      waiting = 0,
    })
  end,
}
