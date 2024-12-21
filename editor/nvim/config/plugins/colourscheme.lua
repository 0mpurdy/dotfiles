return {

  -- Colorscheme
  {
    'navarasu/onedark.nvim',
    config = function()
      -- todo: revisit this with proper neovim syntax
      vim.cmd([[
        let g:onedark_config = {
            \ 'style': 'warmer',
        \}
        silent! colorscheme onedark
      ]])
    end
  },
  -- {
  --   -- a nice one but not using right now
  --   'bluz71/vim-moonfly-colors'
  -- },

  -- Neovim syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    -- todo: this is supposed to be equivalent to the vim-plug
    --
    -- {'do': ':TSUpdate'}
    --
    -- Need to check it's actually right
    config = function()
      vim.cmd('TSUpdate')
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },


}
