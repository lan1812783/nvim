local servers = {
  'lua_ls',
  'html',
  'cssls',
  'ts_ls',
  'jdtls',
  'clangd',
  'bashls',
  'yamlls',
  'basedpyright',
  'harper_ls',
}
if vim.g.go then
  servers = vim.list_extend({ 'gopls' }, servers)
end

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
  servers = servers,
}

function M.utils.isBufSizeBig(buf)
  local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
  return ok and size > M.constants.big_file_size
end

return M
