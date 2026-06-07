vim.pack.add { 'https://github.com/folke/which-key.nvim' }

require('which-key').setup()

local map = require('commons').utils.map
map('n', '<leader>?', function()
  require('which-key').show { global = false }
end, { desc = 'Buffer Local Keymaps (which-key)' })
