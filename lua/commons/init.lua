local servers = {
  'lua_ls',
  'stylua',
  'html',
  'cssls',
  'ts_ls',
  'jdtls',
  'clangd',
  'bashls',
  'yamlls',
  'basedpyright',
  'harper_ls',
  'buf_ls',
}
if vim.g.go then
  servers = vim.list_extend({ 'gopls' }, servers)
end

local M = {
  constants = {
    big_file_size = 50 * 1024, -- 50 KB
  },
  utils = {
    ---Wrapper around `vim.keymap.set` with `opts` defaulted to `{ noremap = true, silent = true }`
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

---@param buf integer Buffer id, or 0 for current buffer
---@return boolean bufSizeBig whether the file size of the buffer is greater than `M.constants.big_file_size` or not
function M.utils.isBufSizeBig(buf)
  local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
  return ok and size > M.constants.big_file_size
end

return M
