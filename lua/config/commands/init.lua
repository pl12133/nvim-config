local M = {}

--- Register autocmds that keep @l in sync with filetype.
function M.setup()
  require("config.commands.smart_bufdelete")
end

return M
