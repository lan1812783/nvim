vim.pack.add {
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

require('mason-lspconfig').setup {
  automatic_enable = false, -- enable manually via `vim.lsp.enable()`
}

local ensure_installed = vim.list_extend({
  'checkstyle',
  'google-java-format',
  'prettierd',
  'sonarlint-language-server',
  'pylint',
  'isort',
  'black',
  'shellcheck', -- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
  'shfmt', -- https://github.com/bash-lsp/bash-language-server?tab=readme-ov-file#dependencies
  'tree-sitter-cli', -- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#requirements
  'gitleaks',
}, require('commons').servers)

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
        print('mason-tool-installer installed/updated ' .. vim.inspect(e.data)) -- print the table that lists the programs that were installed
      end
    end)
  end,
})
