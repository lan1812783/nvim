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

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
        command = 'codelldb',
        args = { '--port', '${port}' },
      },
    }
    dap.configurations.c = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local path
          vim.ui.input({ prompt = 'Path to executable: ', default = vim.loop.cwd() .. '/build/' }, function(input)
            path = input
          end)
          vim.cmd [[redraw]]
          return path
        end,
        cwd = '${workspaceFolder}',
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    local map = require('commons').utils.map
    map('n', '<F5>', function() dap.continue() end, { desc = 'DAP: continue' })
    map('n', '<F10>', function() dap.step_over() end, { desc = 'DAP: step over' })
    map('n', '<F11>', function() dap.step_into() end, { desc = 'DAP: step into' })
    map('n', '<F12>', function() dap.step_out() end, { desc = 'DAP: step out' })
    map('n', '<s-F5>', function() dap.disconnect({ terminateDebuggee = true}); dap.close() dapui.close() end, { desc = 'DAP: stop' })
    map('n', '<Leader>b', function() dap.toggle_breakpoint() end, { desc = 'DAP: toggle breakpoint' })
    map('n', '<Leader>B', function() dap.set_breakpoint() end, { desc = 'DAP: set breakpoint' })
    map('n', '<Leader>cp', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'DAP: set condiitional breakpoint' })
    map('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'DAP: set log point' })
    map('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'DAP: open RELP' })
    map('n', '<Leader>dl', function() dap.run_last() end, { desc = 'DAP: run last' })

    local widgets = require('dap.ui.widgets')
    map({'n', 'v'}, '<Leader>dh', function() widgets.hover() end, { desc = 'DAP: hover' })
    map({'n', 'v'}, '<Leader>dp', function() widgets.preview() end, { desc = 'DAP: preview' })
    map('n', '<Leader>df', function() widgets.centered_float(widgets.frames) end, { desc = 'DAP: view the current frame in a centered floating window' })
    map('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes) end, { desc = 'DAP: view the current scopes in a centered floating window' })

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg=0, fg='#993939', bg='#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg=0, fg='#61afef', bg='#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg=0, fg='#98c379', bg='#31353f' })

    vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text='󰜋', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
    vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
  end,
}

return dapui
