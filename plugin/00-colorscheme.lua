vim.pack.add {
  'https://github.com/folke/tokyonight.nvim',
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}

-- Tip: Pick a color palette and paste it somewhere temporary, such as at the end of this file, so you can easily reference it while browsing. Most Lua language servers will even highlight hex codes directly in your file, making colors easier to preview at a glance.

-- Color palettes: https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/colors
require('tokyonight').setup {
  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.border = colors.dark5
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights tokyonight.Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    highlights.DapBreakpoint = { fg = colors.red }
    highlights.DapBreakpointLine = { bg = colors.bg_highlight }

    highlights.DapBreakpointCondition = { fg = colors.red }
    highlights.DapBreakpointConditionLine = { bg = colors.bg_highlight }

    highlights.DapLogPoint = { fg = colors.cyan }
    highlights.DapLogPointLine = { bg = colors.bg_highlight }

    highlights.DapStopped = { fg = colors.green }
    highlights.DapStoppedLine = { bg = colors.blue7 }

    highlights.DapBreakpointRejected = { fg = colors.red }
    highlights.DapBreakpointRejectedLine = { bg = colors.bg_highlight }
  end,
}
-- vim.cmd.colorscheme 'tokyonight'

-- Color palettes: https://github.com/catppuccin/nvim/tree/main/lua/catppuccin/palettes
require('catppuccin').setup {
  -- https://github.com/catppuccin/nvim#overwriting-highlight-groups
  custom_highlights = function(colors)
    -- Default DAP highlight groups: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/dap.lua
    return {
      DapBreakpointLine = { bg = colors.surface0 },
      DapBreakpointConditionLine = { bg = colors.surface0 },
      DapLogPointLine = { bg = colors.surface0 },
      DapStoppedLine = { bg = colors.surface1 },
      DapBreakpointRejectedLine = { bg = colors.surface0 },
    }
  end,
}
vim.cmd.colorscheme 'catppuccin-macchiato'
