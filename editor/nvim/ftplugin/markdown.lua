local function createDailyLog()
  vim.api.nvim_put({ '', '## ' }, 'l', true, true)
  vim.cmd.normal(vim.api.nvim_replace_termcodes('$<leader>ido<esc>', true, false, true))
  vim.api.nvim_put(
    {
      '[Project](projects/path/readme.md)',
      '',
      '- PR reviews',
      '  +',
      '',
    },
    'l',
    true,
    true)
  vim.cmd.normal('$')
end

vim.keymap.set("n", "<leader>il", createDailyLog, {noremap=true})

-- Execute mappings (for code blocks)
vim.keymap.set("n", "<leader>xl", ":.lua<cr>", {noremap=true})
vim.keymap.set("v", "<leader>xl", ":lua<cr>", {noremap=true})

vim.keymap.set("n", "<leader>xb", ":.!bash<cr>", {noremap=true})
vim.keymap.set("v", "<leader>xb", ":!bash<cr>", {noremap=true})

vim.treesitter.start()
