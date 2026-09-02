-- F1 to auto format file
vim.keymap.set("n", "<F1>", ":w<CR>:!autopep8 -i --aggressive --aggressive %<CR>", {noremap=true})

-- Leader format mapping
-- vim.keymap.set("n", "<leader>e", ":w<CR>:!autopep8 -i %<CR>", {noremap=true})
-- vim.keymap.set("n", "<leader>e", ":w<CR>:!isort %<CR>:!black %<CR>", {noremap=true})
vim.keymap.set("n", "<leader>e", ":w<CR>:!ruff check --select I --fix % && ruff format %<CR>", {noremap=true})
-- vim.keymap.set("n", "<leader>e", ":w<CR>:!isort %<CR>:!black %<CR>:!ruff check --select I --fix % && ruff format %<CR>", {noremap=true})

-- " Format on save
local group = vim.api.nvim_create_augroup('ruff_format_on_save', { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  buffer = 0,
  callback = function(opts)
    local root_dir = nil

      local get_clients = vim.lsp.get_clients
      local clients = get_clients({ bufnr = opts.buf, name = 'pyright' })

      if clients and #clients > 0 then
        root_dir = clients[1].config.root_dir
      end

      if root_dir then
        -- Escape the root directory path to prevent shell injection/errors with spaces
        local safe_dir = vim.fn.shellescape(root_dir)

        -- Use %:p to get the ABSOLUTE path of the file since we are changing directories
        local cmd = string.format(
          "silent! !cd %s && uv run ruff check --select I --fix %%:p && uv run ruff format %%:p", 
          safe_dir
        )
        vim.api.nvim_command(cmd)
      else
        -- Fallback if Pyright isn't attached
        vim.api.nvim_command("silent! !uv run ruff check --select I --fix %:p && uv run ruff format %:p")
      end
  end
})

-- F4 to run current file
-- vim.keymap.set("n", "<F4>", ":w<CR>:vsp term://python3 %<CR>i", {noremap=true})
-- current dir version
vim.keymap.set("n", "<F4>", ":w<CR>:vsp | terminal cd %:p:h && uv run %:p<CR>i", {noremap=true})
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

vim.treesitter.start()
