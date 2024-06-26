local autopairs = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = {
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
    },
  },
  config = function()
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    local npairs = require 'nvim-autopairs'
    npairs.setup()
  end,
  -- use opts = {} for passing setup options
  -- this is equalent to setup({}) function
}

return autopairs
