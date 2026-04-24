local function vite_wait_for()
  vim.cmd.normal(vim.api.nvim_replace_termcodes("Iawait waitFor(() => <esc>$i)<esc>", true, true, true))
end

vim.api.nvim_create_user_command("WaitFor", vite_wait_for, {})
