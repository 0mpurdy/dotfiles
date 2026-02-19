return {

  -- Git integration
  {
    'tpope/vim-fugitive',
    init = function()
      -- todo: revisit this with proper neovim syntax
      vim.cmd([[
        set diffopt+=vertical
      ]])
    end
  },

  -- Git browser integration
  {
    'tpope/vim-rhubarb',
    enabled = false,
  },

  -- surround with quotes or brackets
  {
    'tpope/vim-surround'
  },

  -- For repeating plugin actions
  {
    'tpope/vim-repeat'
  },

  -- For incrementing dates properly
  {
    'tpope/vim-speeddating'
  },

  -- Better comment support
  {
    'tpope/vim-commentary'
  },

  -- powerful word substitution
  -- Smart case handling
  {
    'tpope/vim-abolish',
    enabled = true,
  },

  -- Some useful normal mode mappings
  -- {
  --   Plug 'tpope/vim-unimpaired'
  -- },

}
