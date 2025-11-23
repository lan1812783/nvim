---@type vim.lsp.Config
return {
  settings = {
    -- https://luals.github.io/wiki/settings
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      format = {
        enable = false,
      },
    },
  },
}
