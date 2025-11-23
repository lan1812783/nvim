---@module 'lazy'
---@type LazySpec
local M = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    npairs.setup()
  end,
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}

return M
