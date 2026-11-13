local bundles = {
  vim.fn.glob(
    '$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar',
    true
  ),
}

local java_test_bundles =
  vim.split(vim.fn.glob('$MASON/share/java-test/*.jar', true), '\n')
local excluded = {
  'com.microsoft.java.test.runner-jar-with-dependencies.jar',
  'jacocoagent.jar',
}
for _, java_test_jar in ipairs(java_test_bundles) do
  local fname = vim.fn.fnamemodify(java_test_jar, ':t')
  if not vim.tbl_contains(excluded, fname) then
    table.insert(bundles, java_test_jar)
  end
end

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
        enabled = false, -- use google_java_format instead
      },
    },
  },
  init_options = {
    bundles = bundles,
  },
}
