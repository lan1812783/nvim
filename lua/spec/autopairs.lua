local autopairs = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {}, -- this is equalent to setup({}) function
  dependencies = {
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        require('nvim-treesitter.install').update { with_sync = true }
      end,
    },
  },
}

function autopairs.config()
  local npairs = require 'nvim-autopairs'

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  local cmp = require 'cmp'
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  npairs.setup {
    check_ts = true, -- treesitter integration
    enable_check_bracket_line = false,
    ignored_next_char = '[%w%.]', -- will ignore alphanumeric and `.` symbol
    fast_wrap = {},
  }
end

return autopairs
