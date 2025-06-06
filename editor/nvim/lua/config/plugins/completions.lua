return {

  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },

  -- Snippet support
  { 'SirVer/ultisnips' },
  {
    'honza/vim-snippets',
    init = function()
      -- todo: revisit this with proper neovim syntax
      vim.cmd([[
        let g:UltiSnipsExpandTrigger="ƒ"
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsJumpBackwardTrigger="<c-z>"
      ]])
    end
  },

  -- Docs generation
  -- {
  --   'kkoomen/vim-doge',
  --   -- todo: this is supposed to be equivalent to the vim-plug
  --   --
  --   -- { 'do': { -> doge#install() } }
  --   --
  --   -- Need to check it's actually right
  --   init = function()
  --     -- todo: revisit this with proper neovim syntax
  --     vim.cmd([[
  --       doge#install()
  --     ]])
  --   end
  -- },

  -- todo: no time for sorting this right now
  -- " Auto completion
  -- if has('nvim')
  --   " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  -- else
  --   " if using venv - `pip install pynvim`
  --   "Plug 'Shougo/deoplete.nvim'
  --   Plug 'roxma/nvim-yarp'
  --   Plug 'roxma/vim-hug-neovim-rpc'
  -- endif
  -- " let g:deoplete#enable_at_startup = 1
  -- " " deoplete tab-complete
  -- " :inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

}
