---@module 'lazy'
---@type LazySpec
local M = {
  'nvimtools/none-ls.nvim',
  cond = not vim.o.diff,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local null_ls = require 'null-ls'

    local sources = {
      null_ls.builtins.diagnostics.checkstyle.with {
        extra_args = { '-c', '/google_checks.xml' }, -- or "/sun_checks.xml" or path to self written rules
      },
      null_ls.builtins.formatting.google_java_format,
      null_ls.builtins.formatting.prettierd.with {
        extra_args = { '--single-quote=true' },
      },
      -- Python
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black.with {
        extra_args = { '--line-length=80', '--skip-string-normalization' },
      },
      null_ls.builtins.diagnostics.gitleaks,
    }

    null_ls.setup {
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
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
