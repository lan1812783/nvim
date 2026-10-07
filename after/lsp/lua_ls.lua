---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    -- https://luals.github.io/wiki/settings
    Lua = {
      format = {
        enable = false, -- use stylua instead
      },
    },
  },
}
