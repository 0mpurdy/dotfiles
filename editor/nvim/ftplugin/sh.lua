-- F4 to run current file
vim.keymap.set("n", "<F4>", ":w<CR>:vsp term://sh %<CR>i", {noremap=true})
