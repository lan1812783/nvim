local telescope = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  dependencies = {
    {
      'nvim-lua/plenary.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
  },
}

function telescope.config()
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  local tls = require('telescope')
  tls.load_extension('fzf')
  tls.setup {
    defaults = {
      file_ignore_patterns = {
        '.git/', -- the slash '/' at the end make sure that only the files inside .git folder are ignored, not the .gitignore, .gitlab-ci.yml, etc which start by '.git' in their names
        'node_modules',
        '__pycache__'
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        no_ignore = false, -- change to true to find ignored files also
      },
    },
  }
end

return telescope
