---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
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
