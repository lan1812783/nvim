local dapui = {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    {
      'mfussenegger/nvim-dap',
    },
  },
  config = function()
    local dap, dapui = require('dap'), require('dapui')

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    local map = require('commons').utils.map
    map('n', '<F5>', function() dap.continue() end, { desc = 'DAP: continue' })
    map('n', '<F10>', function() dap.step_over() end, { desc = 'DAP: step over' })
    map('n', '<F11>', function() dap.step_into() end, { desc = 'DAP: step into' })
    map('n', '<F12>', function() dap.step_out() end, { desc = 'DAP: step out' })
    map('n', '<Leader>b', function() dap.toggle_breakpoint() end, { desc = 'DAP: toggle breakpoint' })
    map('n', '<Leader>B', function() dap.set_breakpoint() end, { desc = 'DAP: set breakpoint' })
    map('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'DAP: set breakpoint' })
    map('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'DAP: open RELP' })
    map('n', '<Leader>dl', function() dap.run_last() end, { desc = 'DAP: run last' })

    local widgets = require('dap.ui.widgets')
    map({'n', 'v'}, '<Leader>dh', function() widgets.hover() end, { desc = 'DAP: hover' })
    map({'n', 'v'}, '<Leader>dp', function() widgets.preview() end, { desc = 'DAP: preview' })
    map('n', '<Leader>df', function() widgets.centered_float(widgets.frames) end, { desc = 'DAP: view the current frame in a centered floating window' })
    map('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes) end, { desc = 'DAP: view the current scopes in a centered floating window' })
  end,
}

return dapui
