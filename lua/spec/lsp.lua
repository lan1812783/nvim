local lsp = {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp',
    },
  },
}

function lsp.config()
  local map = require('commons').utils.map

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  map('n', '<space>d', vim.diagnostic.open_float)
  map('n', '[d', vim.diagnostic.goto_prev)
  map('n', ']d', vim.diagnostic.goto_next)
  map('n', '<space>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      map('n', 'gD', vim.lsp.buf.declaration, opts)
      map('n', 'gd', vim.lsp.buf.definition, opts)
      map('n', 'K', vim.lsp.buf.hover, opts)
      map('n', 'gi', vim.lsp.buf.implementation, opts)
      map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      map('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      map('n', '<space>D', vim.lsp.buf.type_definition, opts)
      map('n', '<space>rn', vim.lsp.buf.rename, opts)
      map({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      map('n', 'gr', vim.lsp.buf.references, opts)
      map('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })

  ----------

  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')

  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  local capabilities = cmp_nvim_lsp.default_capabilities()
  for _, server in pairs(require('commons').servers) do
    local opts = {
      capabilities = capabilities,
      settings = {},
    }

    local require_ok, settings = pcall(require, 'settings.' .. server)
    if require_ok then
      opts.settings = vim.tbl_deep_extend('force', settings, opts.settings)
    end

    lspconfig[server].setup(opts)
  end

  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
      suffix = '',
    },
  }
  vim.diagnostic.config(config)
end

return lsp
