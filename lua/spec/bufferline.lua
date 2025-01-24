local M = {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
    },
    {
      'neovim/nvim-lspconfig',
    },
  },
  config = function()
    vim.opt.termguicolors = true

    require('bufferline').setup {
      options = {
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(
                result,
                { text = '  ' .. error, link = 'DiagnosticError' }
              )
            end

            if warning ~= 0 then
              table.insert(
                result,
                { text = '  ' .. warning, link = 'DiagnosticWarn' }
              )
            end

            if hint ~= 0 then
              table.insert(
                result,
                { text = '  ' .. hint, link = 'DiagnosticHint' }
              )
            end

            if info ~= 0 then
              table.insert(
                result,
                { text = '  ' .. info, link = 'DiagnosticInfo' }
              )
            end
            return result
          end,
        },
        diagnostics = 'nvim_lsp',
        --- count is an integer representing total count of errors
        --- level is a string 'error' | 'warning'
        --- diagnostics_dict is a dictionary from error level ('error', 'warning' or 'info')to number of errors for each level.
        --- this should return a string
        --- Don't get too fancy as this function will be executed a lot
        diagnostics_indicator = function(
          count,
          level,
          diagnostics_dict,
          context
        )
          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = e == 'error' and ' '
              or (e == 'warning' and ' ' or ' ')
            s = s .. n .. sym
          end
          return s
        end,
        -- indicator = {
        --   style = 'underline',
        -- },
        numbers = 'buffer_id', -- ordinal & buffer_id
        separator_style = 'thick',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'center',
          },
        },
      },
    }
  end,
}

return M
