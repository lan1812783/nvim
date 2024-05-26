local commons = {}

commons = {
  constants = {
    big_file_size = 100 * 1024, -- 100 KB
  },
  utils = {
    map = function(mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then
        options = vim.tbl_extend('force', options, opts)
      end
      vim.keymap.set(mode, lhs, rhs, options)
    end,
    isBufSizeBig = function(buf)
      local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
      return ok and size > commons.constants.big_file_size
    end,
  },
  servers = {
    'lua_ls',
    'html',
    'cssls',
    'tsserver',
    'jdtls',
    'clangd',
    'gopls',
    'bashls',
    'yamlls',
  },
}

return commons
