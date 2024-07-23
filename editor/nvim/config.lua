vim.filetype.add({
  filename = {
    ['tsconfig.json'] = 'jsonc',
  },
})

-- Plugins
require('mason').setup()

require('lspconfig').pyright.setup { }

-- require('lspconfig').pylsp.setup { 
--   settings = { 
--     pylsp = { 
--       plugins = { 
--         pylint = {
--           enabled = false
--         }, 
--         pycodestyle = { 
--           enabled = "false" 
--         }, 
--       }, 
--     }, 
--   }, 
-- }

-- require("typescript-tools").setup {}
require('lspconfig').tsserver.setup {}

local cmp = require('cmp')
cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = {
    ['<C-cr>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<Tab>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<S-Tab>'] = function(fallback)
      if not cmp.select_prev_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  }
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});

local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- ********************************* Keymaps **********************************

-- vim.keymap.set('n', '<Leader>gd', '<Plug>(doge-generate)')
