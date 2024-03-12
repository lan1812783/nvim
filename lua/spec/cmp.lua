local completion = {
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
      'L3MON4D3/LuaSnip',
      -- follow latest release.
      version = '1.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
    {
      'hrsh7th/cmp-nvim-lua',
    },
  },
}

function completion.config()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  require('luasnip.loaders.from_vscode').lazy_load()

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match '%s'
        == nil
  end

  local kind_icons = {
    Text = '󰉿',
    Method = 'm',
    Function = '󰊕',
    Constructor = '',
    Field = '',
    Variable = '󰆧',
    Class = '󰌗',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰌋',
    Snippet = '',
    Color = '󰏘',
    File = '󰈙',
    Reference = '',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰇽',
    Struct = '',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '󰊄',
    Codeium = '󰚩',
    Copilot = '',
  }

  cmp.setup {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = '[LSP]',
          nvim_lua = '[LUA]',
          luasnip = '[Luasnip]',
          buffer = '[Buffer]',
          -- path = '[Path]',
          -- emoji = '[Emoji]',
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
      -- { name = 'path' },
      -- { name = 'emoji' },
    }),
    experimental = {
      ghost_text = true,
    },
  }
end

return completion
