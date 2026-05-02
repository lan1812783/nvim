if vim.o.diff then
  return
end

vim.pack.add {
  'https://github.com/saghen/blink.cmp',
  -- Mason must be set up (not only be loaded) in advance for resolving $MASON environment variable (used in jdtls' settings)
  'https://github.com/neovim/nvim-lspconfig',
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local map = require('commons').utils.map

    map({ 'n' }, 'grr', function()
      vim.lsp.buf.references { includeDeclaration = false }
    end, {
      buffer = args.buf,
      desc = 'LSP: lists all the references',
    })

    -- Mitigate high loading time on big file
    local bufSizeNotBig = not require('commons').utils.isBufSizeBig(args.buf)

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- :h lsp-inlay_hint
    if client:supports_method 'textDocument/inlayHint' then
      vim.lsp.inlay_hint.enable(bufSizeNotBig, { bufnr = args.buf })
      map('n', 'grh', function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf },
          { bufnr = args.buf }
        )
      end, { buffer = args.buf, desc = 'LSP: toggle inlay hint' })
    end

    -- :h vim.lsp.foldexpr()
    if bufSizeNotBig and client:supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = 'expr'
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- :h lsp-codelens
    if client:supports_method 'textDocument/codeLens' then
      vim.lsp.codelens.enable(bufSizeNotBig, { bufnr = args.buf })
      map('n', 'grl', function()
        vim.lsp.codelens.enable(
          not vim.lsp.codelens.is_enabled { bufnr = args.buf },
          { bufnr = args.buf }
        )
      end, { buffer = args.buf, desc = 'LSP: toggle code lens' })
    end

    -- :h lsp-attach
    if
      not client:supports_method 'textDocument/willSaveWaitUntil'
      and client:supports_method 'textDocument/formatting'
    then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('formatting', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format {
            bufnr = args.buf,
            id = client.id,
            timeout_ms = 1000,
          }
        end,
      })

      map({ 'n', 'v' }, 'grf', vim.lsp.buf.format, {
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

vim.diagnostic.config {
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = true,
  },
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignInfo',
    },
  },
}
