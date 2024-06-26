local M = {
  'neovim/nvim-lspconfig',
  cond = not vim.g.diffmode, -- 'cond' would install but not load the plugin, whereas 'enabled' would not install the plugin at all
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  config = function()
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<C-W>d', function()
      vim.diagnostic.open_float { focusable = true } -- focus isn't allow by default
    end, { desc = 'LSP: diagnostic' })
    vim.keymap.set(
      'n',
      '<leader>q',
      vim.diagnostic.setloclist,
      { desc = 'LSP: add buffer diagnostics to the location list' }
    )

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local function getOpts(desc)
          return { buffer = ev.buf, desc = desc }
        end
        vim.keymap.set(
          'n',
          'gD',
          vim.lsp.buf.declaration,
          getOpts 'LSP: go to declaration'
        )
        vim.keymap.set(
          'n',
          'gd',
          vim.lsp.buf.definition,
          getOpts 'LSP: go to definiiion'
        )
        vim.keymap.set(
          'n',
          'gi',
          vim.lsp.buf.implementation,
          getOpts 'LSP: go to implementation'
        )
        vim.keymap.set(
          'n',
          '<C-k>',
          vim.lsp.buf.signature_help,
          getOpts 'LSP: signature help'
        )
        vim.keymap.set(
          'n',
          '<leader>wa',
          vim.lsp.buf.add_workspace_folder,
          getOpts 'LSP: add workspace folder'
        )
        vim.keymap.set(
          'n',
          '<leader>wr',
          vim.lsp.buf.remove_workspace_folder,
          getOpts 'LSP: remove workspace folder'
        )
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, getOpts 'LSP: list workspace folders')
        vim.keymap.set(
          'n',
          '<leader>D',
          vim.lsp.buf.type_definition,
          getOpts 'LSP: type definition'
        )
        vim.keymap.set(
          'n',
          '<leader>rn',
          vim.lsp.buf.rename,
          getOpts 'LSP: type definition'
        )
        vim.keymap.set(
          { 'n', 'v' },
          '<leader>ca',
          vim.lsp.buf.code_action,
          getOpts 'LSP: code action'
        )
        vim.keymap.set(
          'n',
          'gr',
          vim.lsp.buf.references,
          getOpts 'LSP: go to references'
        )
        vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, getOpts 'LSP: format buffer')

        -- Mitigate high loading time on big file
        local isBufSizeBig = require('commons').utils.isBufSizeBig
        -- https://neovim.io/doc/user/lsp.html#lsp-inlay_hint
        vim.lsp.inlay_hint.enable(not isBufSizeBig(ev.buf))
        vim.keymap.set('n', 'H', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end)
      end,
    })

    ----------

    -- https://github.com/hrsh7th/cmp-nvim-lsp?tab=readme-ov-file#setup
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    for _, server in pairs(require('commons').servers) do
      local opts = {
        capabilities = capabilities,
      }

      local require_ok, settings = pcall(require, 'settings.' .. server)
      if require_ok then
        opts = vim.tbl_deep_extend('force', settings, opts)
      end

      require('lspconfig')[server].setup(opts)
    end

    local signs = {
      { name = 'DiagnosticSignError', text = '' },
      { name = 'DiagnosticSignWarn', text = '' },
      { name = 'DiagnosticSignHint', text = '' },
      { name = 'DiagnosticSignInfo', text = '' },
    }
    for _, sign in ipairs(signs) do
      vim.fn.sign_define(
        sign.name,
        { texthl = sign.name, text = sign.text, numhl = '' }
      )
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
  end,
}

return M
