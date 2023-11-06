local toggleterm = {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {--[[ things you want to change go here]]},
}

function toggleterm.config()
  -- Must be explicitly enabled
  require('toggleterm').setup {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == 'horizontal' then
        return 20
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    direction = 'vertical',
    close_on_exit = true, -- close the terminal window when the process exits
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    },
  }

  local Terminal  = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

  function _Lazygit_toggle()
    lazygit:toggle()
  end

  local map = require('commons').utils.map
  map('n', '<leader>g', '<cmd>lua _Lazygit_toggle()<CR>')
end

return toggleterm
