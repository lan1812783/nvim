local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup {
      extensions = { 'lazy', 'nvim-dap-ui', 'nvim-tree', 'toggleterm' }, -- extensions 'mason' causes errors
    }
  end,
}

return M
