if vim.g.diffmode then
  return
end

vim.cmd 'setlocal colorcolumn=100'

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local jdtls_dir = vim.fn.expand '$MASON/packages/jdtls'
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Must point to the
-- eclipse.jdt.ls installation
local workspace_dir = jdtls_dir .. '/workspace' .. vim.fn.getcwd()
--                                   ^^
--                                   string concattenation in Lua

function get_cmp_capabilities()
  local require_ok, blink = pcall(require, 'blink.cmp')
  if require_ok then
    return blink.get_lsp_capabilities()
  end
  return {}
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java21_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. vim.fn.expand '$MASON/share/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_*.jar'),

    -- 💀
    '-configuration',
    jdtls_dir .. '/config_linux',
    -- ^^^^^
    -- Change to one of `linux`, `win` or `mac`
    -- Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    '-data',
    workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.root(0, { '.git', 'pom.xml', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      -- configuration = {
      --   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      --   -- And search for `interface RuntimeOption`
      --   -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      --   runtimes = {
      --     {
      --       name = 'JavaSE-1.8',
      --       path = '~/.sdkman/candidates/java/8.0.402-tem',
      --     },
      --     {
      --       name = 'JavaSE-17',
      --       path = '~/.sdkman/candidates/java/17.0.10-tem',
      --     },
      --   },
      -- },
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },

  -- We didn't advertise the completion capabilities to jdtls when configuring the lsp, so we are adding that here
  capabilities = get_cmp_capabilities(),
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
