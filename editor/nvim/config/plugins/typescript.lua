return {

  -- Required for nvim-typescript
  { 'HerringtonDarkholme/yats.vim' },
  -- Required for nvim-typescript
  { 'Shougo/denite.nvim' },

  -- Typescript support
  { 'neovim/nvim-lspconfig' },
  { 'nvim-lua/plenary.nvim' },
  -- { 'pmizio/typescript-tools.nvim' },
  -- { 'mhartington/nvim-typescript', {'do': './install.sh'} },

  -- Typescript syntax highlighting
  -- { 'leafgarland/typescript-vim' },

  -- React prettify tsx
  {
    'prettier/vim-prettier',
    -- todo: figure out how best to do this:
    -- \ 'do': 'yarn install --frozen-lockfile --production',
    -- \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
  },

  -- HTML edit
  {
    'mattn/emmet-vim'
  },

}
