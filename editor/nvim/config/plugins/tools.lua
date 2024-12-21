return {

  -- UI for vim undo tree
  {
    'mbbill/undotree'
  },

  -- Alignment tool
  {
    'junegunn/vim-easy-align',
    init = function()
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
    end
  },

  -- Directory navigation
  {
    'scrooloose/nerdtree',
    init = function()
      vim.keymap.set("n", "<Leader>no", ":NERDTreeToggle<cr>", {noremap=true})
      vim.keymap.set("n", "<Leader>nf", ":NERDTreeFind<cr>", {noremap=true})
    end
  },

}
