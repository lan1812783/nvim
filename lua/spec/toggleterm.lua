local M = {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    -- Must be explicitly enabled
    require('toggleterm').setup {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      direction = 'float',
      auto_scroll = false, -- automatically scroll to the bottom on terminal output
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      },
    }

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

    function _Lazygit_toggle()
      lazygit:toggle()
    end

    local map = require('commons').utils.map
    map('n', '<leader>g', '<cmd>lua _Lazygit_toggle()<CR>')
  end,
}

return M
