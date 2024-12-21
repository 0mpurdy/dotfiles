return {

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

}
