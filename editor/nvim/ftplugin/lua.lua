-- F4 to run current file
vim.keymap.set("n", "<F4>", ":w<CR>:vsp term://lua %<CR>i", {noremap=true})
