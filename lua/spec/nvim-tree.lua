local M = {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- empty setup using defaults
    require('nvim-tree').setup {
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      git = {
        ignore = false,
      },
    }

    local map = require('commons').utils.map
    map('n', '<leader>e', ':NvimTreeToggle<CR>')
  end,
}

return M
