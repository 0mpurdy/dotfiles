-- Neovim Lua config file

-- Should the mappings be optimised for ergodox?
local ergodox = false

-- ************************** Syntax highlighting *****************************

vim.filetype.add({
  filename = {
    ['tsconfig.json'] = 'jsonc',
  },
})

-- ******************************** Plugins ***********************************

require('config.lazy')

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
        -- treesitter highlighting for dockerfiles really just not working at
        -- the moment
        if lang == 'dockerfile' then
            return true
        end
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

require('lspconfig').gopls.setup {}

-- ****************************** Completions *********************************

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local cmpMapping = {
  ['<c-space>'] = cmp.mapping.confirm {
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

local next_completion = function(fallback)
    if not cmp.select_next_item() then
      if vim.bo.buftype ~= 'prompt' and has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end
  end

local previous_completion = function(fallback)
    if not cmp.select_prev_item() then
      if vim.bo.buftype ~= 'prompt' and has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end
  end

if ergodox then
  cmpMapping['<c-n>'] = next_completion
  cmpMapping['<c-e>'] = previous_completion
else
  cmpMapping['<c-j>'] = next_completion
  cmpMapping['<c-k>'] = previous_completion
end

-- https://github.com/hrsh7th/nvim-cmp?tab=readme-ov-file#recommended-configuration
cmp.setup {
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = cmpMapping,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }
  }, {
    { name = 'buffer' }
  }),
}

local on_attach = function(_, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
});

local completion_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- ******************************** LSP maps **********************************

require'lspconfig'.lua_ls.setup({
  capabilities = completion_capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  },
  on_attach = on_attach,
})

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
      if buf_name ~= "" and buf_name:find("^term") == nil and buf_name:find("^fugitive") == nil and vim.api.nvim_buf_is_loaded(value) then
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

local function reverseLines()
  local vstart = vim.api.nvim_buf_get_mark(0, "<")
  local vend = vim.api.nvim_buf_get_mark(0, ">")

  local line_start = vstart[1] - 1
  local line_end = vend[1]

  for k, v in pairs(lines) do
    lines[k] = string.reverse(v)
  end

  local lines = vim.api.nvim_buf_set_lines(0, line_start, line_end, true, lines)
end

vim.api.nvim_create_user_command("ReverseVLines", reverseLines, {})

local function test()
  -- print(dump(vim.fn.getbufinfo(81)))
  -- vim.api.nvim_buf_set_lines(0, 0, 0, true, {dump(vim.fn.getbufinfo(89))})
  print('Test success')

  local lineNum = vim.api.nvim_win_get_cursor(0)
  local row, col = unpack(lineNum)
  local bufname = vim.api.nvim_buf_get_name(0)

  vim.fn.setreg("+", bufname .. "#" .. row)
end

vim.api.nvim_create_user_command("Test", test, {})

vim.api.nvim_create_user_command("AddTable", function ()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local tableText = {
    '| Before | After |',
    '| --- | --- |',
    '| | |',
  }
  vim.api.nvim_put(tableText, 'l', false, true)
end, {})

vim.api.nvim_create_user_command('PasteWithCodeFence', function()
  vim.api.nvim_put({ '', '' }, 'l', true, true)
  vim.cmd.normal('k')
  vim.api.nvim_put({ '```' }, 'l', false, true)

  local lines = {}
  for s in vim.fn.getreg('+'):gmatch("[^\r\n]+") do
      table.insert(lines, s)
  end

  vim.api.nvim_put(lines, 'l', false, true)
  vim.api.nvim_put({ '```' }, 'l', false, true)
end, {})

-- ******************************** Keymaps ***********************************

-- local function get_visual_selection()
--   local s_start = vim.fn.getpos("'<")
--   local s_end = vim.fn.getpos("'>")
--   local n_lines = math.abs(s_end[2] - s_start[2]) + 1
--   local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
--   lines[1] = string.sub(lines[1], s_start[3], -1)
--   if n_lines == 1 then
--     lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
--   else
--     lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
--   end
--   return table.concat(lines, '\n')
-- end

-- local function search_visual_selection()
--   -- exit out of visual mode
--   local esc_key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
--   vim.api.nvim_feedkeys(esc_key, 'n', false)

--   local visually_selected_text = get_visual_selection()

--   print(visually_selected_text)
-- end

-- vim.keymap.set("v", "<leader>/", search_visual_selection, {noremap=true})

local vlua = '"\'<.\'>lua<cr>"'

-- vim.keymap.set('n', '<Leader>gd', '<Plug>(doge-generate)')
vim.keymap.set("n", "<Leader>nt", next_terminal, {noremap=true})
vim.keymap.set("n", "<Leader>nnn", next_no_name, {noremap=true})
vim.keymap.set("n", "<leader>wr", reflow_window, {noremap=true})
-- don't know what the difference is between these two tbh
-- vim.keymap.set("n", "<leader><leader>l", ":luafile %<cr>", {noremap=true})
vim.keymap.set("n", "<leader><leader>l", ":source %<cr>", {noremap=true})
vim.keymap.set("v", "<leader><leader>px", ":put =execute(" .. vlua ..")", {noremap=true})
vim.keymap.set("n", "<leader>x", ":.lua<cr>", {noremap=true})
vim.keymap.set("v", "<leader>x", ":lua<cr>", {noremap=true})
vim.keymap.set("n", "<leader><leader>cl", ":let @+ = execute('luafile %')<cr>", {noremap=true})

vim.keymap.set("n", "<leader>sl", ":Git log --graph --decorate --abbrev-commit --all --date=format:'%a' --pretty=format:\"%h %an %d%n%n%s%n\"<cr>", {noremap=true})
vim.keymap.set("n", "<leader>sal", ":Git log --graph --decorate --abbrev-commit --all --date=format:'%a' --pretty=format:\"%h %d%n%an %ae %ad %aI%n%cn %ce %cd %cI%n%n%s%n\"<cr>", {noremap=true})

-- Visual selection maps
vim.keymap.set("n", "<Leader>V", "$v0", {noremap=true})
vim.keymap.set("v", "<Leader>{", "?{<cr>j", {noremap=true})
vim.keymap.set("v", "<Leader>}", "/}<cr>k", {noremap=true})

-- Yank maps
vim.keymap.set("n", "<Leader>Y", "$v0\"+y", {noremap=true})

-- ********************************* Bugs *************************************

vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "[Dd]ockerfile" , group = optional_group, command = "TSBufDisable highlight" })
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "*.lua" , command = "nnoremap <F5> :luafile %<cr>" })

-- ******************************** Augment ***********************************

vim.g.augment_workspace_folders = {'~/dev/goldeneye-research/'}

-- ********************************* Work *************************************

require('pytilia')
