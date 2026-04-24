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

-- pyright
-- typescript-language-server
-- gopls
-- lua-language-server

-- ********************* Plugins - Syntax Highlighting ************************

require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install {
    "bash",
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
}

-- **************************** Plugins - Python ******************************

vim.lsp.enable('pyright')

-- vim.lsp.config.pylsp = {
--   settings = {
--     pylsp = {
--       plugins = {
--         pylint = {
--           enabled = false
--         },
--         pycodestyle = {
--           enabled = false
--         },
--       },
--     },
--   },
-- }

-- ************************** Plugins - Typescript ****************************

-- vim.lsp.enable('typescript-tools')
-- vim.lsp.enable('tsserver')
vim.lsp.enable('ts_ls')

-- **************************** Plugins - golang ******************************

vim.lsp.enable('gopls')

-- ****************************** Completions *********************************

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local cmpMapping = {
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

vim.lsp.config("lua_ls", {
  capabilities = completion_capabilities,
  on_init = function(client)
    if not client.workspace_folders or #client.workspace_folders == 0 then
      return
    end

    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
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
    },
  },
  on_attach = on_attach,
})

vim.lsp.enable('lua_ls')

vim.lsp.enable('terraformls')

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

vim.api.nvim_create_user_command('UrlDecodeLine', function()
  -- Get the current line under the cursor
  local line = vim.api.nvim_get_current_line()

  -- Replace '+' with spaces
  local decoded = line:gsub('+', ' ')

  -- Replace '%XX' hex codes with their corresponding characters
  decoded = decoded:gsub('%%(%x%x)', function(hex)
    return string.char(tonumber(hex, 16))
  end)

  -- Replace the current line with the decoded string
  vim.api.nvim_set_current_line(decoded)
end, { desc = 'URL decode the current line' })

vim.api.nvim_create_user_command("AddTable", function ()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local tableText = {
    '| Before | After |',
    '| --- | --- |',
    '| | |',
  }
  vim.api.nvim_put(tableText, 'l', false, true)
end, {})

local function get_live_visual_selection()
  -- Get the positions of the start of visual mode 'v' and the cursor '.'
  local s_pos = vim.fn.getpos('v')
  local e_pos = vim.fn.getpos('.')

  -- Get the current mode to handle block/line/char correctly
  local mode = vim.fn.mode()
  local region = vim.fn.getregion(s_pos, e_pos, { type = mode })

  return table.concat(region, "\n")
end

local function get_previous_visual_selection()
  -- Get the marks (1-indexed)
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Use nvim_buf_get_text (0-indexed, so we subtract 1)
  -- end_pos[3] is the column; we use that directly for end-inclusive
  local lines = vim.api.nvim_buf_get_text(
    0,
    start_pos[2] - 1,
    start_pos[3] - 1,
    end_pos[2] - 1,
    end_pos[3],
    {}
  )

  return {
    ["start"]=start_pos,
    ["end"]=end_pos,
    ["text"]=table.concat(lines, "\n")
  }
end

local function overwrite_previous_visual_selection(selection, lines)
  vim.api.nvim_buf_set_text(
        0,
        selection["start"][2] - 1,
        selection["start"][3] - 1,
        selection["end"][2] - 1,
        selection["end"][3],
        lines
      )
end

-- test value 1775830235
vim.api.nvim_create_user_command('FromUnixTimestamp', function()
  -- local selection = get_visual_selection()
  local selection = get_previous_visual_selection()

  local iso_date = os.date("!%Y-%m-%dT%H:%M:%SZ", selection["text"])

  overwrite_previous_visual_selection(
    selection,
    { '"' .. iso_date .. '"' }
  )
  print(iso_date)
end, {})

vim.api.nvim_create_user_command('FromPemCert', function()
  vim.cmd(":%!openssl x509 -text -noout")
end, {})

vim.api.nvim_create_user_command('DecodeJWT', function()
  vim.cmd([[%s/\./\r/g]])
  vim.cmd(':1,1!base64 -d')
  vim.cmd(':2,2!base64 -d')
  vim.cmd(':2,2!jq')
end, {})

vim.api.nvim_create_user_command('PasteWithCodeFence', function()
  local total_lines = vim.api.nvim_buf_line_count(0)
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  print(total_lines..' '..current_line..' == '..total_lines==current_line)

  vim.api.nvim_put({ '' }, 'l', true, true)
  if total_lines == current_line then
    vim.api.nvim_put({ '' }, 'l', true, true)
  end
  vim.api.nvim_put({ '```' }, 'l', false, true)

  local lines = {}
  for s in vim.fn.getreg('+'):gmatch("[^\r\n]+") do
      table.insert(lines, s)
  end

  vim.api.nvim_put(lines, 'l', false, true)
  vim.api.nvim_put({ '```' }, 'l', false, true)
  if total_lines == current_line then
    vim.cmd.normal('dd')
  else
    vim.cmd.normal('k')
  end
  vim.cmd.normal(vim.api.nvim_replace_termcodes('k<c-v>4l6kd', true, false, true))
end, {})

local function open_weekly_log()
  -- find .git directory
  local git_marker = vim.fs.find('.git', { path = vim.fn.getcwd(), upward = true })[1]

  if not git_marker then
    vim.notify("Not inside a git repository!", vim.log.levels.WARN)
    return
  end

  -- vim.fs.find returns the path to .git, so we need the parent directory
  local git_root = vim.fs.dirname(git_marker)

  -- current week's monday
  local now = os.date("*t")
  local saturday = 7
  local monday = 2
  -- calculate how many days passed since Monday
  local days_since_monday = (now.wday + (saturday - monday)) % saturday
  now.day = now.day - days_since_monday

  -- os.time() automatically handles month/year rollovers (e.g., if day becomes negative)
  local monday_timestamp = os.time(now)
  local monday_str = os.date("%Y-%m-%d", monday_timestamp)

  local log_dir = git_root .. "/log"
  local file_path = log_dir .. "/" .. monday_str .. ".md"

  vim.cmd("edit " .. file_path)
end

vim.api.nvim_create_user_command("WeeklyLog", open_weekly_log, {})

local function big_log_format()
  vim.bo.filetype = 'log'
  vim.wo.wrap = false
end

vim.api.nvim_create_user_command("BigLogFormat", big_log_format, {})

-- ******************************** Keymaps ***********************************

-- return a representation of the selected text
-- suitable for use as a search pattern
--
-- Adapted from https://vi.stackexchange.com/a/41425
local function get_visual_selection(escape)
    local old_reg = vim.fn.getreg("v")
    vim.cmd('normal! gv"vy')
    local raw_search = vim.fn.getreg("v")
    vim.fn.setreg("v", old_reg)
    if escape then
        local escaped = vim.fn.escape(raw_search, '\\/.*$^~[]')
        return vim.fn.substitute(escaped, "\n", '\\n', "g")
    end
    return raw_search
end

local function search_visual_selection()
  -- exit out of visual mode
  local esc_key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc_key, 'n', false)

  local visually_selected_text = ""

  vim .schedule(function ()
    visually_selected_text = get_visual_selection()

    -- Set the search register and perform the search
    vim.fn.setreg("/", visually_selected_text)
    vim.cmd("normal! n")
  end)

  vim.schedule(function() vim.notify(visually_selected_text) end)
end

vim.keymap.set("x", "<leader>/", search_visual_selection, {noremap=true})

local function filter_in_new_buffer()
  -- exit out of visual mode
  local esc_key = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc_key, 'n', false)

  vim.schedule(function ()
    local visually_selected_text = get_visual_selection() .. "\n"
    vim.cmd('enew')

    local lines = {}
    for s in visually_selected_text:gmatch("(.-)\n") do
        table.insert(lines, s)
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)

    vim.api.nvim_feedkeys(':%!', 'n', false)
  end)
end

vim.keymap.set("v", "<leader>!", filter_in_new_buffer, {noremap=true})

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

local function paste_replace()
  local new_line = vim.api.nvim_get_current_line()
  local new_len = #new_line
  local new_col = vim.api.nvim_win_get_cursor(0)[2]

  -- If the line is empty or the cursor is at the last available character,
  -- we use lowercase p to ensure the text is appended at the end.
  if new_len == 0 or new_col >= new_len - 1 then
    -- Use lowercase 'p' to paste after if at the end of the line
    vim.cmd('normal! "0p')
  else
    -- Use uppercase 'P' to paste before
    vim.cmd('normal! "0P')
  end
end

-- Replace maps
-- vim.keymap.set('n', '<leader>r', 'diw"0P', { desc = 'Replace word' })
vim.keymap.set('n', '<leader>r', function()
  vim.cmd('normal! diw')
  paste_replace()
end, { desc = 'Replace word' })
-- vim.keymap.set('v', '<leader>r', 'd"0P', { desc = 'Replace visual selection' })
vim.keymap.set('v', '<leader>r', function()
  vim.cmd('normal! d')
  paste_replace()
end, { desc = 'Replace visual selection' })

-- ********************************* Bugs *************************************

vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "[Dd]ockerfile" , group = optional_group, command = "TSBufDisable highlight" })
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "*.lua" , command = "nnoremap <F5> :luafile %<cr>" })

-- ******************************** Augment ***********************************

vim.g.augment_workspace_folders = {'~/dev/goldeneye-research/'}

-- *************************** Personal scripts *******************************

require('mod/jsonify')

-- ********************************* Work *************************************

require('pytilia')
