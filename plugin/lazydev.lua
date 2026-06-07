vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/folke/lazydev.nvim',
}

require('lazydev').setup {
  ---@module 'lazydev'
  ---@type lazydev.Library.spec[]
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    -- https://www.reddit.com/r/neovim/comments/1rssfs9/a_new_use_for_lspconfig_providing_types_for_your
    { path = 'nvim-lspconfig', words = { 'lspconfig' } },
  },
}
