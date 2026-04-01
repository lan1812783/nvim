---@type vim.lsp.Config
return {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. vim.fn.expand '$MASON/share/jdtls/lombok.jar',
  },
  ---@type lspconfig.settings.jdtls
  settings = {
    -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    java = {
      format = {
        enabled = false,
      },
    },
  },
}
