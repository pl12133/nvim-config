--- Sets the @l macro register for quick debug logging.
--- Play it with `@l` (or `@@` to repeat).
local M = {}

--- Macro strings keyed by filetype.
--- Each macro: yank word under cursor, new line below, insert log statement for the variable.
local macros = {
  javascriptreact = [[yeoconsole.log("pa:", pa);]],
  typescriptreact = [[yeoconsole.log("pa:", pa);]],
  ruby            = [[yeoputs "pa: #{pa}"]],
}

--- Update @l for the current buffer's filetype.
function M.apply()
  local macro = macros[vim.bo.filetype]
  if macro then
    vim.fn.setreg("l", macro)
  end
end

--- Register autocmds that keep @l in sync with filetype.
function M.setup()
  vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("log_macro", { clear = true }),
    callback = M.apply,
  })

  -- Set @l for the buffer Neovim opened with.
  M.apply()
end

return M
