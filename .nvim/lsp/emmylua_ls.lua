-- Configure `emmylua_ls` via `exrc` (:h 'exec) so that the `vim` APIs can be
-- used, e.g. `vim.api.nvim_get_runtime_file(). Note that even though
-- `emmylua_ls` supports dynamic config file with `.emmylua.lua`, it can not
-- interpret the `vim` APIs on its own.

---@type vim.lsp.Config
return {
  settings = {
    emmylua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
}
