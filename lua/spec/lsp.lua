local M = {
  'neovim/nvim-lspconfig',
  cond = not vim.o.diff, -- 'cond' would install but not load the plugin, whereas 'enabled' would not install the plugin at all
  dependencies = {
    {
      'saghen/blink.cmp',
      'mason-org/mason.nvim', -- for resolving $MASON in jdtls' settings
    },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        -- Mitigate high loading time on big file
        local bufSizeNotBig =
          not require('commons').utils.isBufSizeBig(args.buf)

        -- :h lsp-inlay_hint
        vim.lsp.inlay_hint.enable(bufSizeNotBig)
        vim.keymap.set('n', 'H', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = 'LSP: toggle inlay hint' })

        if bufSizeNotBig then
          -- :h vim.lsp.foldexpr()
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client:supports_method 'textDocument/foldingRange' then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldmethod = 'expr'
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
          end
        end
      end,
    })

    ----------

    -- With Neovim 0.11, blink.cmp automatically advertises its capabilities to all LSP servers (https://github.com/Saghen/blink.cmp/blob/main/plugin/blink-cmp.lua)
    for _, server in pairs(require('commons').servers) do
      local require_ok, settings = pcall(require, 'settings.' .. server)
      if require_ok then
        vim.lsp.config(server, settings)
      end
      vim.lsp.enable(server)
    end

    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
    local signs =
      { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config {
      update_in_insert = true,
      severity_sort = true,
      float = {
        source = true,
      },
      virtual_text = true,
    }
  end,
}

return M
