local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true, },
}

function lualine.config()
  require('lualine').setup()
end

return lualine
