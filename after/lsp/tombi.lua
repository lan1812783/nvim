---@type vim.lsp.Config
return {
  settings = {
    ---@type lspconfig.settings.tombi
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
