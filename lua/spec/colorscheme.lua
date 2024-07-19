local M = {
  'folke/tokyonight.nvim',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('tokyonight').setup {
      on_colors = function(colors)
        colors.border = colors.dark5
      end,
    }

    vim.cmd [[colorscheme tokyonight-night]]
  end,
}

return M
