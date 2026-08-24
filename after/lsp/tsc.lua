---@type vim.lsp.Config
return {
  settings = {
    -- https://github.com/microsoft/typescript-go/blob/main/internal/ls/lsutil/userpreferences.go
    ['js/ts'] = {
      format = {
        enabled = false, -- use prettierd instead
      },
    },
  },
}
