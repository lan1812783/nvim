local M = {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      lazy = true,
    },
  },
  config = function()
    local settings = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    require('mason').setup(settings)
    require('mason-lspconfig').setup {
      ensure_installed = require('commons').servers,
      automatic_installation = true,
    }
  end,
}

return M
