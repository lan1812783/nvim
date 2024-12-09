local M = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp',
    },
    {
      'hrsh7th/cmp-buffer',
    },
    {
      'hrsh7th/cmp-path',
    },
    {
      'hrsh7th/cmp-cmdline',
    },
    {
      'saadparwaiz1/cmp_luasnip',
    },
    {
      -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#install
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = 'make install_jsregexp',
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
    {
      'hrsh7th/cmp-nvim-lua',
    },
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#add-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
    local kind_icons = {
      Text = '',
      Method = '󰆧',
      Function = '󰊕',
      Constructor = '',
      Field = '󰇽',
      Variable = '󰂡',
      Class = '󰠱',
      Interface = '',
      Module = '',
      Property = '󰜢',
      Unit = '',
      Value = '󰎠',
      Enum = '',
      Keyword = '󰌋',
      Snippet = '',
      Color = '󰏘',
      File = '󰈙',
      Reference = '',
      Folder = '󰉋',
      EnumMember = '',
      Constant = '󰏿',
      Struct = '',
      Event = '',
      Operator = '󰆕',
      TypeParameter = '󰅲',
    }

    cmp.setup {
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
      formatting = {
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind =
            string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            latex_symbols = '[LaTeX]',
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = 'nvim_lua' }, -- https://github.com/hrsh7th/cmp-nvim-lua?tab=readme-ov-file#setup
        { name = 'lazydev', group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions, https://github.com/folke/lazydev.nvim?tab=readme-ov-file#-installation
      }, {
        { name = 'buffer' },
      }),
      experimental = {
        ghost_text = true,
      },
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}

return M
