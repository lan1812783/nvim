local M = {
  'folke/snacks.nvim',
  opts = {
    picker = {
      sources = {
        files = { hidden = true },
        grep = { hidden = true },
      },
    },
  },
  keys = {
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
  },
}

return M
