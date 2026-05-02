vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  {
    src = 'https://github.com/igorlfs/nvim-dap-view',
    version = vim.version.range '1.*',
  },
}

local dap = require 'dap'
local dapview = require 'dap-view'

dapview.setup {
  winbar = {
    controls = {
      enabled = true,
    },
  },
  virtual_text = {
    enabled = true,
  },
}

local map = require('commons').utils.map

map('n', '<F5>', dap.continue, { desc = 'DAP: continue' })
map('n', '<F10>', dap.step_over, { desc = 'DAP: step over' })
map('n', '<F11>', dap.step_into, { desc = 'DAP: step into' })
map('n', '<F12>', dap.step_out, { desc = 'DAP: step out' })
map('n', '<S-F5>', function()
  dap.disconnect { terminateDebuggee = true }
  dap.close()
end, { desc = 'DAP: stop' })
map(
  'n',
  '<leader>b',
  dap.toggle_breakpoint,
  { desc = 'DAP: toggle breakpoint' }
)
map('n', '<leader>cp', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'DAP: set conditional breakpoint' })
map('n', '<leader>lp', function()
  dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
end, { desc = 'DAP: set log point' })

vim.fn.sign_define('DapBreakpoint', {
  text = '',
  texthl = 'DapBreakpoint',
  linehl = 'DapBreakpointLine',
  numhl = 'DapBreakpoint',
})
vim.fn.sign_define('DapBreakpointCondition', {
  text = '',
  texthl = 'DapBreakpointCondition',
  linehl = 'DapBreakpointConditionLine',
  numhl = 'DapBreakpointCondition',
})
vim.fn.sign_define('DapLogPoint', {
  text = '󰜋',
  texthl = 'DapLogPoint',
  linehl = 'DapLogPointLine',
  numhl = 'DapLogPoint',
})
vim.fn.sign_define('DapStopped', {
  text = '',
  texthl = 'DapStopped',
  linehl = 'DapStoppedLine',
  numhl = 'DapStopped',
})
vim.fn.sign_define('DapBreakpointRejected', {
  text = '',
  texthl = 'DapBreakpointRejected',
  linehl = 'DapBreakpointRejectedLine',
  numhl = 'DapBreakpointRejected',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dap-repl', 'dap-view' },
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})
