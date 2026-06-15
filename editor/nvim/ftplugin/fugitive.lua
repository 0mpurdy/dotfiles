vim.keymap.set("n", "cr", ":Git cherry-pick --continue<CR>", {
    buffer = true,
    silent = true,
    desc = "Git cherry-pick continue"
})
