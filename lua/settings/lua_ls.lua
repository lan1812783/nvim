---@type vim.lsp.Config
return {
  settings = {
    -- https://luals.github.io/wiki/settings
    Lua = {
      codeLens = {
        enable = true,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
      },
    },
  },
}
