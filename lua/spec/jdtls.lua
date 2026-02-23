---@module 'lazy'
---@type LazySpec
local M = {
  'mfussenegger/nvim-jdtls',
  config = function()
    local jdtls = require 'jdtls'
    local map = require('commons').utils.map

    -- Keymap inspired by IntelliJ's Optimize Imports feature (https://www.jetbrains.com/guide/tips/optimize-imports)
    map('n', '<C-M-o>', function()
      jdtls.organize_imports()
    end, { desc = 'Jdtls: organize import' })
  end,
}

return M
