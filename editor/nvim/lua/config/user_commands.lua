vim.api.nvim_create_user_command('DiffMarks', function()
  -- Save the current buffer and window view (cursor position, scrolling)
  local orig_buf = vim.api.nvim_get_current_buf()
  local orig_view = vim.fn.winsaveview()

  -- Jump to mark A, get absolute path, escape it
  vim.cmd("silent! normal! 'A")
  local file_a = vim.fn.fnameescape(vim.fn.expand('%:p'))

  -- Jump to mark B, get absolute path, escape it
  vim.cmd("silent! normal! 'B")
  local file_b = vim.fn.fnameescape(vim.fn.expand('%:p'))

  -- Restore original buffer and view
  vim.api.nvim_set_current_buf(orig_buf)
  vim.fn.winrestview(orig_view)

  -- Run the Fugitive command
  vim.cmd(string.format("Git diff --no-index %s %s", file_a, file_b))
end, { desc = "Minimal Fugitive diff between global marks A and B" })
