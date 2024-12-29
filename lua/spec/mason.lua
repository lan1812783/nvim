local M = {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
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
    require('mason-tool-installer').setup {
      ensure_installed = vim.list_extend({
        'clang-format',
        'codelldb',
        'delve',
        'eslint_d',
        'gofumpt',
        'google-java-format',
        'jdtls',
        'prettierd',
        'sonarlint-language-server',
        'stylua',
        'pylint',
        'isort',
        'black',
      }, require('commons').servers),
    }
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsStartingInstall',
      callback = function()
        vim.schedule(function()
          print 'mason-tool-installer is starting'
        end)
      end,
    })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MasonToolsUpdateCompleted',
      callback = function(e)
        vim.schedule(function()
          if next(e.data) ~= nil then
            print(
              'mason-tool-installer installed/updated ' .. vim.inspect(e.data)
            ) -- print the table that lists the programs that were installed
          end
        end)
      end,
    })
  end,
}

return M
