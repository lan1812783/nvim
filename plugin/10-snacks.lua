vim.pack.add { 'https://github.com/folke/snacks.nvim' }

require('snacks').setup {
  picker = {
    sources = {
      files = { hidden = true },
      grep = { hidden = true },
    },
    ui_select = false,
    win = {
      input = {
        keys = {
          ['<c-j>'] = { 'history_forward', mode = { 'i', 'n' } },
          ['<c-k>'] = { 'history_back', mode = { 'i', 'n' } },
        },
      },
    },
  },
  words = { enabled = true },
}

local map = require('commons').utils.map

map('n', '<leader><space>', function()
  Snacks.picker.smart()
end, { desc = 'Smart Find Files' })

map('n', '<leader>fc', function()
  Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Find Config File' })

map('n', '<leader>ff', function()
  Snacks.picker.files()
end, { desc = 'Find Files' })

map('n', '<leader>sg', function()
  Snacks.picker.grep()
end, { desc = 'Grep' })
