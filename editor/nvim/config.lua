-- Neovim Lua config file

-- ************************** Syntax highlighting *****************************

vim.filetype.add({
  filename = {
    ['tsconfig.json'] = 'jsonc',
  },
})

-- ******************************** Plugins ***********************************

require('mason').setup()

-- ********************* Plugins - Syntax Highlighting ************************

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "c_sharp",
    "css",
    "diff",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "tsx", "javascript" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
  },
}

-- **************************** Plugins - Python ******************************

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

-- ************************** Plugins - Typescript ****************************

-- require("typescript-tools").setup {}
-- require('lspconfig').tsserver.setup {}
require('lspconfig').ts_ls.setup {}


-- ******************************** LSP maps **********************************

local cmp = require('cmp')
cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = {
    ['<cr>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<down>'] = function(fallback)
      if not cmp.select_next_item() then
        if vim.bo.buftype ~= 'prompt' and has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,

    ['<up>'] = function(fallback)
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

-- ******************************* Functions **********************************

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local function reflow_window()
  vim.cmd("NERDTreeClose")
  vim.cmd.normal(vim.api.nvim_replace_termcodes("<C-w>h", true, true, true))
  vim.cmd("only")

  -- Load a non terminal and non git buffer in the left half
  local current_buf_name = vim.api.nvim_buf_get_name(0)
  if current_buf_name == "" or current_buf_name:find("^term") or current_buf_name:find("^fugitive") ~= nil then
    for key,value in pairs(vim.api.nvim_list_bufs()) do
      local buf_name = vim.api.nvim_buf_get_name(value)
      if buf_name ~= "" and buf_name:find("^term") == nil and buf_name:find("^fugitive") == nil then
        vim.api.nvim_win_set_buf(0, value)
        break
      end
    end
  end

  -- Load a terminal buffer in the right half
  vim.cmd("vsplit")
  vim.cmd.normal(vim.api.nvim_replace_termcodes("<C-w>l", true, true, true))
  for key,value in pairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(value)
    if buf_name:find("^term") ~= nil then
      vim.api.nvim_win_set_buf(0, value)
      break
    end
  end

  current_buf_name = vim.api.nvim_buf_get_name(0)
  if current_buf_name:find("^term") == nil then
    vim.cmd("terminal")
  end
  vim.cmd.normal(vim.api.nvim_replace_termcodes("G<c-w>h", true, true, true))
end

local function next_terminal()
  -- search for the next terminal buffer after the current one in the list
  local current_buf_name = vim.api.nvim_buf_get_name(0)
  local after_current = false
  for key,value in pairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(value)
    if buf_name == current_buf_name then
      after_current = true
    elseif after_current and buf_name:find("^term") then
      vim.api.nvim_win_set_buf(0, value)
      return
    end
  end

  -- didn't find it after, circle back to the start
  for key,value in pairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(value)
    if buf_name:find("^term") then
      vim.api.nvim_win_set_buf(0, value)
      return
    end
  end

  print('No terminal buffers found')
end

local function next_no_name()
  -- Open the next unnamed buffer
  local current_bufnr = vim.fn.bufnr()
  local after_current = false
  for key,value in pairs(vim.api.nvim_list_bufs()) do
    local buf_info = vim.fn.getbufinfo(value)[1]
    if buf_info.bufnr > current_bufnr and buf_info.listed == 1 and buf_info.name == "" then
      vim.api.nvim_win_set_buf(0, value)
      return
    end
  end

  -- didn't find it after, circle back to the start
  for key,value in pairs(vim.api.nvim_list_bufs()) do
    local buf_info = vim.fn.getbufinfo(value)[1]
    if buf_info.listed == 1 and buf_info.name == "" then
      vim.api.nvim_win_set_buf(0, value)
      return
    end
  end

  print('No "[No name]" buffer found')
end

local function test()
  -- print(dump(vim.fn.getbufinfo(81)))
  vim.api.nvim_buf_set_lines(0, 0, 0, true, {dump(vim.fn.getbufinfo(89))})
end

-- ******************************** Keymaps ***********************************

-- vim.keymap.set('n', '<Leader>gd', '<Plug>(doge-generate)')
vim.keymap.set("n", "<Leader>nt", next_terminal, {noremap=true})
vim.keymap.set("n", "<Leader>nnn", next_no_name, {noremap=true})
vim.keymap.set("n", "<leader>wr", reflow_window, {noremap=true})


