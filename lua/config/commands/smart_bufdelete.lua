local function smart_bufdelete()
  local buf_to_close = vim.api.nvim_get_current_buf()

  -- find all windows currently showing this buffer
  local wins = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_buf(win) == buf_to_close
  end, vim.api.nvim_list_wins())

  -- find a replacement: alternate buffer, else next listed buffer, else new blank buffer
  local function get_replacement()
    local alt = vim.fn.bufnr("#")
    if alt ~= -1 and alt ~= buf_to_close and vim.fn.buflisted(alt) == 1 then
      return alt
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= buf_to_close and vim.fn.buflisted(buf) == 1 and vim.api.nvim_buf_is_loaded(buf) then
        return buf
      end
    end

    return vim.api.nvim_create_buf(true, false) -- blank listed buffer
  end

  local replacement = get_replacement()

  for _, win in ipairs(wins) do
    vim.api.nvim_win_set_buf(win, replacement)
  end

  if vim.api.nvim_buf_is_valid(buf_to_close) then
    vim.api.nvim_buf_delete(buf_to_close, { force = false })
  end
end

vim.api.nvim_create_user_command("Bd", smart_bufdelete, {})
vim.keymap.set("n", "<leader>bd", smart_bufdelete, { desc = "Delete buffer, keep split" })
