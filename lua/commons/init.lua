local commons = {}

commons = {
  utils = {
    map =
      function(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then
          options = vim.tbl_extend('force', options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
      end,
  },
  servers = {
    'lua_ls',
    'html',
    'cssls',
    'tsserver',
    'jdtls',
    'gopls',
    'bashls',
  },
}

return commons
