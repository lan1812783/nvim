local M = {
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'mfussenegger/nvim-jdtls',
  },
  config = function()
    require('sonarlint').setup {
      server = {
        cmd = {
          'sonarlint-language-server',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          -- paths to the analyzers you need, using those for python and java in this example
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarpython.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarcfamily.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarjava.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonargo.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarhtml.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonariac.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarjs.jar',
          vim.fn.expand '$MASON/share/sonarlint-analyzers/sonarjavasymbolicexecution.jar',
        },
      },
      filetypes = {
        'c',
        'go',
        'html',
        'css',
        'javascript',
        'typescript',
        'dockerfile',
        -- Tested and working
        'python',
        'cpp',
        'java',
      },
    }
  end,
}

return M
