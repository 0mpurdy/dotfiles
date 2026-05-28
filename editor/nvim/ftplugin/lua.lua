-- F4 to run current file
vim.keymap.set("n", "<F4>", ":w<CR>:vsp term://lua %<CR>i", {noremap=true})

vim.keymap.set("n", "<leader>x", ":.lua<cr>", {noremap=true})
vim.keymap.set("v", "<leader>x", ":lua<cr>", {noremap=true})

vim.treesitter.start()
