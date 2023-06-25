local map = require('commons').utils.map

local nvim_tree = {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
}

function nvim_tree.config()
  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require('nvim-tree').setup({
    git = {
      ignore = false,
    },
  })

  map('n', '<leader>e', ':NvimTreeToggle<CR>')
end

return nvim_tree
