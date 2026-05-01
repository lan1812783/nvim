if not vim.g.go then
  return
end

vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/leoluz/nvim-dap-go',
}

require('dap-go').setup()
