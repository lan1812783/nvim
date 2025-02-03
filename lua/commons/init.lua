local M = {
  constants = {
    big_file_size = 50 * 1024, -- 50 KB
  },
  utils = {
    map = function(mode, lhs, rhs, opts)
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
    'ts_ls',
    -- 'jdtls', -- allow only nvim-jdtls to start the client (https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#nvim-lspconfig-and-nvim-jdtls-differences)
    'clangd',
    'gopls',
    'bashls',
    'yamlls',
    'pyright',
    'harper_ls',
  },
}

function M.utils.isBufSizeBig(buf)
  local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
  return ok and size > M.constants.big_file_size
end

return M
