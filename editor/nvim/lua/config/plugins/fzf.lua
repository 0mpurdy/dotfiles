return {

  -- Fuzzy find
  {
    'junegunn/fzf',
    -- todo
    -- { 'do': { -> fzf#install() } }
  },
  {
    'junegunn/fzf.vim',
    config = function(plugin)
      vim.opt.rtp:append("~/.fzf")

      -- todo: revisit this with proper neovim syntax
      vim.cmd([[
        let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

        function! s:build_quickfix_list(lines)
          call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
          copen
          cc
        endfunction

        let g:fzf_action = {
          \ 'ctrl-q': function('s:build_quickfix_list') }
      ]])

     local function ripgrepSearchInDir(dir)
        local rg_command = 'rg --column --line-number --no-heading --color=always --smart-case ""'
        vim.api.nvim_call_function('fzf#vim#grep', { rg_command, 1, { dir = dir } })
      end

     local function ripgrepSearchFilesInDir(dir)
        local rg_command = 'rg --files'
        vim.api.nvim_call_function('fzf#vim#grep', { rg_command, 1, { dir = dir } })
      end

     local function ripgrepSearchAllFilesInDir(dir)
        local rg_command = 'rg --files --no-ignore-vcs'
        vim.api.nvim_call_function('fzf#vim#grep', { rg_command, 1, { dir = dir } })
      end

      -- search config
      vim.keymap.set('n', '<Leader>sc', ':Files ' .. vim.fn.stdpath('config') .. '<cr>', {noremap=true})
      vim.keymap.set('n', '<Leader>sic', function() ripgrepSearchInDir(vim.fn.stdpath('config')) end, {noremap=true})

      -- search dotfiles
      local dotfilesDir = '~/dev/dotfiles'
      vim.keymap.set('n', '<Leader>sd', ':Files ' .. dotfilesDir .. '<cr>', {noremap=true})
      vim.keymap.set('n', '<Leader>sid', function() ripgrepSearchInDir(dotfilesDir) end, {noremap=true})

      -- search working dir
      vim.keymap.set('n', '<Leader>sw', function() ripgrepSearchFilesInDir(vim.fn.getcwd()) end, {noremap=true})
      vim.keymap.set('n', '<Leader>saw', function() ripgrepSearchAllFilesInDir(vim.fn.getcwd()) end, {noremap=true})

      -- search current file
      vim.keymap.set('n', '<Leader>sif', ':BLines<cr>', {noremap=true})

      -- search runtime path
      local runtimeFolders = ''
      for _, folder in ipairs(vim.api.nvim_list_runtime_paths()) do
        runtimeFolders = runtimeFolders .. ' ' .. folder
      end
      local function searchRuntimePath()
        vim.api.nvim_call_function(
          'fzf#run',
          {
            vim.api.nvim_call_function(
              'fzf#wrap',
              {
                {
                  source = 'find ' ..
                  runtimeFolders ..
                  " -type d -name test -o -type d -name '.git*' -prune -o -type f -print",
                  sink = 'e'
                } }) })
      end
      vim.keymap.set('n', '<Leader>sr', searchRuntimePath, {noremap=true})

    end
  },

}
