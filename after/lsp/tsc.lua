---@type vim.lsp.Config
return {
  settings = {
    -- https://github.com/microsoft/TypeScript/blob/main/tsc/internal/ls/lsutil/userpreferences.go
    ['js/ts'] = {
      format = {
        enabled = false, -- use prettierd instead
      },
    },
  },
}
