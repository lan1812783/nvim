---@module 'lazy'
---@type LazySpec
local M = {
  url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim.git',
  cond = not vim.o.diff,
  dependencies = {
    'neovim/nvim-lspconfig',
    'mason-org/mason.nvim', -- for resolving $MASON in the analyzer paths
    'lewis6991/gitsigns.nvim',
  },
  config = function()
    require('sonarlint').setup {
      server = {
        -- https://gitlab.com/schrieveslaach/dotfiles/-/blob/main/dot_config/nvim/lua/schrieveslaach/plugins/sonarlint.lua?ref_type=heads
        cmd = vim
          .iter({
            'sonarlint-language-server',
            -- Ensure that sonarlint-language-server uses stdio channel
            '-stdio',
            '-analyzers',
            -- paths to the analyzers you need, using those for python and java in this example
            vim.fn.expand('$MASON/share/sonarlint-analyzers/*.jar', true, 1),
          })
          :flatten()
          :totable(),
      },
      filetypes = {
        'c',
        'go',
        'html',
        'css',
        'javascript',
        'typescript',
        -- Tested and working
        'dockerfile',
        'python',
        'cpp',
        'java',
      },
    }
  end,
}

return M
