local M = {
  'nvimtools/none-ls.nvim',
  cond = not vim.g.diffmode,
  dependencies = {
    {
      'nvim-lua/plenary.nvim',
    },
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local null_ls = require 'null-ls'

    local sources = {
      null_ls.builtins.formatting.clang_format.with {
        disabled_filetypes = { 'java' }, -- use google_java_format formatter instead
      },
      null_ls.builtins.diagnostics.checkstyle.with {
        extra_args = { '-c', '/google_checks.xml' }, -- or "/sun_checks.xml" or path to self written rules
      },
      null_ls.builtins.formatting.google_java_format,
      null_ls.builtins.formatting.prettierd.with {
        extra_args = { '--single-quote=true' },
      },
      null_ls.builtins.formatting.stylua,
      -- Python
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black.with {
        extra_args = { '--line-length=80', '--skip-string-normalization' },
      },
      null_ls.builtins.formatting.shfmt.with {
        extra_args = { '-i', '2', '-ci', '-bn' }, -- https://github.com/mvdan/sh/blob/ba0f5f2a1661a86e813dbe0ee0da60e46f12f56d/cmd/shfmt/shfmt.1.scd?plain=1#L125
      },
    }
    if vim.g.go then
      sources =
        vim.list_extend({ null_ls.builtins.formatting.gofumpt }, sources)
    end

    null_ls.setup {
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}

return M
