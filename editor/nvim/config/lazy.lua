-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {

    -- UI for vim undo tree
    {
      'mbbill/undotree'
    },

    -- Fuzzy find
    {
      'junegunn/fzf',
      -- todo
      -- { 'do': { -> fzf#install() } }
    },
    {
      'junegunn/fzf.vim',
      config = function(plugin)
        -- vim.opt.rtp:append(plugin.dir .. "~/.fzf")

        -- todo: revisit this with proper neovim syntax
        vim.cmd([[
          set rtp+=~/.fzf
          let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

          function! s:build_quickfix_list(lines)
            call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
            copen
            cc
          endfunction

          let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list') }
        ]])
      end
    },

    -- Language Server Protocol manager (LSP)
    {
        "williamboman/mason.nvim"
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

    -- Some useful normal mode mappings
    -- {
    --   Plug 'tpope/vim-unimpaired'
    -- },

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

    -- HTML edit
    {
      'mattn/emmet-vim'
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

    -- Linting
    {
      'w0rp/ale',
      init = function()
        -- ALE error navigation
        vim.keymap.set("n", "]e", ":ALENextWrap<cr>", {noremap=true})
        vim.keymap.set("n", "[e", ":ALEPreviousWrap<cr>", {noremap=true})

        -- todo: revisit this with proper neovim syntax
        vim.cmd([[
          let g:ale_linters = {
          \ 'cs': ['OmniSharp'],
          \ 'javascript': ['eslint'],
          \ 'typescript': ['eslint'],
          \ 'typescriptreact': ['eslint'],
          \}

          let g:ale_fixers = {
          \ 'javascript': ['prettier'],
          \ 'typescript': ['prettier'],
          \ 'typescriptreact': ['prettier'],
          \ 'css': ['prettier'],
          \}

          let g:ale_linters_explicit = 1
          let g:ale_fix_on_save = 1
        ]])
      end
    },

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

    -- C# support
    {
      'OmniSharp/omnisharp-vim'
      -- " Use the stdio version of OmniSharp-roslyn:
      -- let g:OmniSharp_server_stdio = 1
      -- " let g:OmniSharp_server_path = '/Users/mike/Downloads/omnisharp-osx/run'
      -- nnoremap <leader>gd <Plug>(doge-generate)
    },

    -- Powershell syntax highlighting
    -- { 'PProvost/vim-ps1' },

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

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
