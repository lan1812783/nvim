---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.tombi
  settings = {
    tombi = {
      format = {
        rules = {
          ['string-quote-style'] = 'single',
          ['trailing-comment-alignment'] = true,
          ['trailing-comment-space-width'] = 1,
        },
      },
    },
  },
}
