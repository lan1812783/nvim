---@module 'lazy'
---@type LazySpec
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
  end,
}

return M
