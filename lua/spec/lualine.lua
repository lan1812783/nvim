local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup {
      extensions = {
        'lazy',
        'mason',
        'nvim-dap-ui',
        'nvim-tree',
        'quickfix',
        'toggleterm',
        'trouble',
      },
    }
  end,
}

return M
