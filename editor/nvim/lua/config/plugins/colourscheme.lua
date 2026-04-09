return {

  -- Colorscheme
  {
    'navarasu/onedark.nvim',
    config = function()
      vim.g.onedark_config = { style = 'warmer' }
      vim.cmd.colorscheme('onedark')
    end,
  },
  -- {
  --   -- a nice one but not using right now
  --   'bluz71/vim-moonfly-colors'
  -- },

  -- Neovim syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local status, configs = pcall(require, "nvim-treesitter.configs")
      if status then
        configs.setup({
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
                -- nvim_buf_set_keymap) which plugins like which-key dhttps://github.com/pytilia/process-automationisplay
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
        })
      else
        -- If the module is missing, we use the 0.12 native way to 
        -- ensure the parsers you want are actually there.
        vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter")
      end
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },

  -- log file highlighting
  {
    'mtdl9/vim-log-highlighting'
  },

  -- Good enough syntax highlight for MDX in Neovim using Treesitter
  {
    "davidmh/mdx.nvim",
    dependencies = {"nvim-treesitter/nvim-treesitter"}
  }
}
