return {

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

  -- Autocomplete
  {
    'hrsh7th/nvim-cmp',

    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'quangnguyen30192/cmp-nvim-ultisnips'
    },

    config = function()
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      local cmp = require("cmp")

      local next_option = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            end,
            { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
          )
          local prev_option = cmp.mapping(
            function(fallback)
              cmp_ultisnips_mappings.jump_backwards(fallback)
            end,
            { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
          )


      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = {
          ["<c-cr>"] = cmp.mapping.confirm({ select = true }),
          ["<c-space>"] = cmp.mapping.complete(),
          ["<down>"] = next_option,
          ["<c-n>"] = next_option,
          ["<up>"] = prev_option,
          ["<c-e>"] = prev_option,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "ultisnips" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
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
