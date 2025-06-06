return {

  -- UI for vim undo tree
  {
    'mbbill/undotree',
    init = function()
      vim.keymap.set("n", "<leader>su", ":UndotreeToggle<CR>")
    end
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

  -- git log viewer
  {
    'isakbm/gitgraph.nvim',
    enabled = false,
    opts = {
      symbols = {
        merge_commit = 'M',
        commit = '*',
      },
      format = {
        timestamp = '%H:%M:%S %d-%m-%Y',
        fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
      },
      -- hooks = {
      --   on_select_commit = function(commit)
      --     print('selected commit:', commit.hash)
      --   end,
      --   on_select_range_commit = function(from, to)
      --     print('selected range:', from.hash, to.hash)
      --   end,
      -- },
    },
    keys = {
      {
        "<leader>gl",
        function()
          require('gitgraph').draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },

  -- alternative git log viewer
  {
    "rbong/vim-flog",
    enabled = true,
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
    init = function()
      -- vim.keymap.set("n", "<Leader>gl", ":Flogsplit<cr>", {noremap=true})
    end
  },

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- AI agent
  {
    'augmentcode/augment.vim',
    init = function()
      -- vim.g.augment_disable_tab_mapping = true
      -- vim.keymap.set("i", "<c-y>", "<cmd>call augment#Accept()<cr>", {noremap=true})
      vim.keymap.set("n", "<leader>ic", ":Augment chat ", {noremap=true})
    end,
  }
}
