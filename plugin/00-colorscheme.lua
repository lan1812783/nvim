vim.pack.add {
  'https://github.com/folke/tokyonight.nvim',
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}

require('tokyonight').setup {
  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.border = colors.dark5
  end,
}
-- vim.cmd.colorscheme 'tokyonight'

vim.cmd.colorscheme 'catppuccin-macchiato'
