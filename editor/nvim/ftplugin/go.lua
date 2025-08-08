vim.opt_local.expandtab = false  -- Use actual tabs, not spaces
vim.opt_local.tabstop = 4        -- Tab width display
vim.opt_local.shiftwidth = 4     -- Indentation width
vim.opt_local.softtabstop = 4    -- Tab key behavior

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup('go_format_on_save', { clear = true }),
  callback = function(opts)
    if vim.bo[opts.buf].filetype == 'go' then
      vim.api.nvim_command("silent! !go fmt %")
    end
  end
})

local function execute_go_for_file()
  -- Could extend to running based on file context
  --
  -- local buf_name = vim.api.nvim_buf_get_name(0)
  -- local buf_dir = string.sub(buf_name, string.find(buf_name, ".*/") or 0)
  -- vim.cmd.normal(vim.api.nvim_replace_termcodes(":w<CR>:vsp term://echo " .. buf_dir .. " && go run " .. buf_dir .. "<CR>i", true, true, true))

  -- Assume working directory
  vim.cmd.normal(vim.api.nvim_replace_termcodes(":w<CR>:belowright split term://go run .<CR>i", true, true, true))
end

-- F4 to run current file
vim.keymap.set("n", "<F4>", function() execute_go_for_file() end, {noremap=true})
