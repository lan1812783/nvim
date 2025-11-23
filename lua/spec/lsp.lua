---@module 'lazy'
---@type LazySpec
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
        local map = require('commons').utils.map

        map({ 'n' }, 'grr', function()
          vim.lsp.buf.references { includeDeclaration = false }
        end, {
          buffer = args.buf,
          desc = 'LSP: format current selection or buffer',
        })

        -- Mitigate high loading time on big file
        local bufSizeNotBig =
          not require('commons').utils.isBufSizeBig(args.buf)

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- :h lsp-inlay_hint
        if client:supports_method 'textDocument/inlayHint' then
          vim.lsp.inlay_hint.enable(bufSizeNotBig)
          map('n', 'grh', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { buffer = args.buf, desc = 'LSP: toggle inlay hint' })
        end

        -- :h vim.lsp.foldexpr()
        if
          bufSizeNotBig
          and client:supports_method 'textDocument/foldingRange'
        then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldmethod = 'expr'
          vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        -- :h lsp-codelens
        -- https://github.com/neovim/neovim/discussions/24791#discussioncomment-13336751
        if client:supports_method 'textDocument/codeLens' then
          if bufSizeNotBig then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd(
              { 'BufEnter', 'CursorHold', 'InsertLeave' },
              {
                buffer = args.buf,
                group = vim.api.nvim_create_augroup(
                  'code_lens',
                  { clear = true }
                ),
                callback = vim.lsp.codelens.refresh,
              }
            )
          end
          map('n', 'grl', vim.lsp.codelens.run, {
            buffer = args.buf,
            desc = 'LSP: run the code lens available in the current line',
          })
        end

        -- :h lsp-attach
        if
          not client:supports_method 'textDocument/willSaveWaitUntil'
          and client:supports_method 'textDocument/formatting'
        then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup(
              'formatting',
              { clear = false }
            ),
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format {
                bufnr = args.buf,
                id = client.id,
                timeout_ms = 1000,
              }
            end,
          })

          vim.keymap.set({ 'n', 'v' }, 'grf', vim.lsp.buf.format, {
            buffer = args.buf,
            desc = 'LSP: format current selection or buffer',
          })
        end
      end,
    })

    ----------

    -- With Neovim 0.11, blink.cmp automatically advertises its capabilities to all LSP servers (https://github.com/Saghen/blink.cmp/blob/main/plugin/blink-cmp.lua)
    for _, server in pairs(require('commons').servers) do
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
