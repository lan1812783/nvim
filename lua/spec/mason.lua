local M = {
  'mason-org/mason.nvim',
  build = ':MasonUpdate',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
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

    local ensure_installed = vim.list_extend({
      'clang-format',
      'codelldb',
      'google-java-format',
      'jdtls',
      'prettierd',
      'sonarlint-language-server',
      'stylua',
      'pylint',
      'isort',
      'black',
      'shellcheck', -- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
      'shfmt', -- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
    }, require('commons').servers)
    if vim.g.go then
      ensure_installed =
        vim.list_extend({ 'delve', 'gofumpt' }, ensure_installed)
    end

    require('mason').setup(settings)
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
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
