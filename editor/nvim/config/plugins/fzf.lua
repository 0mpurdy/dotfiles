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

      local function silverSearchInDir(dir)
        vim.api.nvim_call_function('fzf#vim#ag', { '', { dir = dir } })
      end

      -- search config
      vim.keymap.set('n', '<Leader>sc', ':Files ' .. vim.fn.stdpath('config') .. '<cr>', {noremap=true})
      vim.keymap.set('n', '<Leader>sic', function() silverSearchInDir(vim.fn.stdpath('config')) end, {noremap=true})

      -- search dotfiles
      local dotfilesDir = '~/dev/dotfiles'
      vim.keymap.set('n', '<Leader>sd', ':Files ' .. dotfilesDir .. '<cr>', {noremap=true})
      vim.keymap.set('n', '<Leader>sid', function() silverSearchInDir(dotfilesDir) end, {noremap=true})

      -- search working dir
      vim.keymap.set('n', '<Leader>sw', ':Files ' .. vim.fn.getcwd() .. '<cr>', {noremap=true})

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
