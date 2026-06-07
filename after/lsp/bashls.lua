---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.bashls
  settings = {
    -- https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
    bashIde = {
      -- Google style (https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd?plain=1#L127)
      shfmt = {
        binaryNextLine = true,
        caseIndent = true,
      },
    },
  },
}
