return {
  cmd = {
    'jdtls',
    '--jvm-arg=-javaagent:' .. vim.fn.expand '$MASON/share/jdtls/lombok.jar',
  },
}
