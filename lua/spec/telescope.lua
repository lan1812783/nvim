local telescope = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = {
    {
      'nvim-lua/plenary.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
  },
}

function telescope.config()
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
        },
      },
      preview = {
        hide_on_startup = true,
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        no_ignore = false, -- change to true to find ignored files also
      },
    },
  }

  -- Load extensions after calling setup function
  tls.load_extension 'fzf'
  tls.load_extension 'live_grep_args'
end

return telescope
