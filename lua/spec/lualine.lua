local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true, },
}

function lualine.config()
  require('lualine').setup({
    extensions = { 'lazy', 'nvim-dap-ui', 'nvim-tree', 'toggleterm' } -- extensions 'mason' causes errors
  })
end

return lualine
