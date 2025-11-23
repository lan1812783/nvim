---@module 'lazy'
---@type LazySpec
local M = {
  'theHamsta/nvim-dap-virtual-text',
  dependencies = {
    {
      'mfussenegger/nvim-dap',
    },
    {
      'nvim-treesitter/nvim-treesitter',
      build = function()
        require('nvim-treesitter.install').update { with_sync = true }()
      end,
    },
  },
  ---@module 'nvim-dap-virtual-text'
  ---@param nvim_dap_virtual_text_options
  opts = {},
}

return M
