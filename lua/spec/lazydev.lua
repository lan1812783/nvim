---@module 'lazy'
---@type LazySpec
local M = {
  'folke/lazydev.nvim',
  ft = 'lua', -- only load on lua files
  ---@module 'lazydev'
  ---@type lazydev.Config
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      -- https://www.reddit.com/r/neovim/comments/1rssfs9/a_new_use_for_lspconfig_providing_types_for_your
      { path = 'nvim-lspconfig', words = { 'lspconfig' } },
    },
  },
}

return M
