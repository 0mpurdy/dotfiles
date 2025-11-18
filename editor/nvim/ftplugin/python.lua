
-- F1 to auto format file
vim.keymap.set("n", "<F1>", ":w<CR>:!autopep8 -i --aggressive --aggressive %<CR>", {noremap=true})

-- Leader format mapping
-- vim.keymap.set("n", "<leader>e", ":w<CR>:!autopep8 -i %<CR>", {noremap=true})
-- vim.keymap.set("n", "<leader>e", ":w<CR>:!isort %<CR>:!black %<CR>", {noremap=true})
vim.keymap.set("n", "<leader>e", ":w<CR>:!ruff check --select I --fix % && ruff format %<CR>", {noremap=true})
-- vim.keymap.set("n", "<leader>e", ":w<CR>:!isort %<CR>:!black %<CR>:!ruff check --select I --fix % && ruff format %<CR>", {noremap=true})

-- " Format on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup('ruff_format_on_save', { clear = true }),
  callback = function(opts)
    if vim.bo[opts.buf].filetype == 'python' then
      vim.api.nvim_command("silent! !ruff check --select I --fix % && ruff format %")
		end
  end
})

-- F4 to run current file
vim.keymap.set("n", "<F4>", ":w<CR>:vsp term://python3 %<CR>i", {noremap=true})
-- F5 to run current dir
vim.keymap.set("n", "<F5>", ":w<CR>:vsp term://python3 __main__.py<CR>i", {noremap=true})
-- F6 to run unit tests
vim.keymap.set("n", "<F6>", ":w<CR>:vsp term://pytest -v -m 'not long'<CR>", {noremap=true})
-- F7 to run single test with debugging
vim.keymap.set("n", "<F7>", ":w<CR>:vsp term://pytest -v --pdb %<CR>", {noremap=true})
-- F8 to run all tests
vim.keymap.set("n", "<F8>", ":w<CR>:vsp term://pytest -v<CR>", {noremap=true})
-- F9 to run code coverage
vim.keymap.set("n", "<F9>", ":w<CR>:vsp term://pytest --cov=. --cov-report term-missing:skip-covered<CR>", {noremap=true})
-- F10 to run code coverage for single file
vim.keymap.set("n", "<F10>", ":w<CR>:vsp term://pytest % --cov=. --cov-report term-missing<CR>", {noremap=true})

-- <leader>K to vimgrep
vim.keymap.set("n", "<leader>K", ":vimgrep ' **/*.py<S-Left><S-Left>'", {noremap=true})

-- Ctrl + / to comment
vim.keymap.set("n", "<C-_>", "0i# <Esc>j", {noremap=true})
-- + to uncomment
vim.keymap.set("n", "+", "02xj", {noremap=true})

-- https://github.com/navarasu/onedark.nvim/issues/251
vim.api.nvim_set_hl(0, "@spell", { link = "Comment" })
