local M = {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-lua/plenary.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
  },
  config = function()
    local builtin = require 'telescope.builtin'
    vim.keymap.set(
      'n',
      '<leader>ff',
      builtin.find_files,
      { desc = 'Telescope: find files' }
    )
    vim.keymap.set(
      'n',
      '<leader>fg',
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = 'Telescope: live grep' }
    )
    vim.keymap.set(
      'n',
      '<leader>fb',
      builtin.buffers,
      { desc = 'Telescope: buffers' }
    )
    vim.keymap.set(
      'n',
      '<leader>fh',
      builtin.help_tags,
      { desc = 'Telescope: help tags' }
    )

    local tls = require 'telescope'

    tls.setup {
      defaults = {
        file_ignore_patterns = {
          '.git/', -- the slash '/' at the end make sure that only the files inside .git folder are ignored, not the .gitignore, .gitlab-ci.yml, etc which start by '.git' in their names
          'node_modules',
          '__pycache__',
        },
        multi_icon = ' ',
        prompt_prefix = ' ',
        selection_caret = '󱞪 ',
        mappings = {
          n = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
          },
          i = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
          },
        },
        preview = {
          hide_on_startup = true,
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }

    -- Load extensions after calling setup function
    tls.load_extension 'fzf'
    tls.load_extension 'live_grep_args'
  end,
}

return M
