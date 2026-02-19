return {

  -- Colorscheme
  {
    'navarasu/onedark.nvim',
    config = function()
      vim.g.onedark_config = { style = 'warmer' }
      vim.cmd.colorscheme('onedark')
    end,
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

  -- log file highlighting
  {
    'mtdl9/vim-log-highlighting'
  },

  -- Good enough syntax highlight for MDX in Neovim using Treesitter
  {
    "davidmh/mdx.nvim",
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  }
}
