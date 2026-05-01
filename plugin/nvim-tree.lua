vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  {
    src = 'https://github.com/nvim-tree/nvim-tree.lua',
    version = vim.version.range '*',
  },
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require('nvim-tree').setup {
  actions = {
    open_file = {
      resize_window = false,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    git_ignored = false,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  view = {
    number = true,
    relativenumber = true,
  },
}

local map = require('commons').utils.map
map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })
