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

    end
  },

}
