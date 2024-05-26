local signature = {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('lsp_signature').setup(opts)

    local map = require('commons').utils.map
    map('n', '<C-k>', function()
      require('lsp_signature').toggle_float_win()
    end, { desc = 'Toggle signature' })
  end,
}

return signature
