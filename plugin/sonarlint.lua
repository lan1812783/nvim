if vim.o.diff then
  return
end

vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  -- Mason must be set up (not only be loaded) in advance for resolving $MASON environment variable
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://gitlab.com/schrieveslaach/sonarlint.nvim',
}

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
