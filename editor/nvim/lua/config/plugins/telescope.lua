return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()

      local builtin = require('telescope.builtin')


      vim.keymap.set('n', '<leader>sf', builtin.git_files, { desc = 'Telescope find files', noremap = true })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers', noremap = true })
      vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = 'Telescope command history', noremap = true })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags', noremap = true })

      -- search config
      local configDir = vim.fn.stdpath('config')
      vim.keymap.set('n', '<leader>sc', function()
        require('telescope.builtin').find_files({
          cwd = configDir,
          prompt_title = 'Search config files',
          hidden = true,
        })
      end, { desc = 'Search config files', noremap = true })
      vim.keymap.set('n', '<leader>sic', function()
        require('telescope.builtin').live_grep({
          cwd = configDir,
          prompt_title = 'Search in config files',
          hidden = true,
        })
      end, { desc = 'Search in config files', noremap = true })

      -- search dotfiles
      local dotfilesDir = '~/dev/dotfiles'
      vim.keymap.set('n', '<leader>sd', function()
        require('telescope.builtin').find_files({
          cwd = dotfilesDir,
          prompt_title = 'Search dotfiles',
          hidden = true,
        })
      end, { desc = 'Search dotfiles', noremap = true })
      vim.keymap.set('n', '<leader>sid', function()
        require('telescope.builtin').live_grep({
          cwd = dotfilesDir,
          prompt_title = 'Search in dotfiles',
          hidden = true,
        })
      end, { desc = 'Search in dotfiles', noremap = true })

      -- search working dir
      vim.keymap.set('n', '<Leader>sw', builtin.find_files, {noremap=true})
      vim.keymap.set('n', '<Leader>siw', builtin.live_grep, {noremap=true})

      -- search current file
      vim.keymap.set('n', '<Leader>sif', builtin.current_buffer_fuzzy_find, { desc = 'Search lines in current buffer' })

      local actions = require("telescope.actions")
      require("telescope").setup({
            defaults = {
              mappings = {
                i = { -- Insert mode (typing in the search prompt)
                  ["<C-s>"] = actions.smart_send_to_qflist + actions.open_qflist,
                },
                n = { -- Normal mode (navigating results with j/k)
                  ["<C-s>"] = actions.smart_send_to_qflist + actions.open_qflist,
                },
              },
            },
          })
    end
}
