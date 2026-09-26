---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.emmylua_ls
  settings = {
    -- https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/docs/config/emmyrc_json_EN.md
    -- https://github.com/EmmyLuaLs/emmylua-analyzer-rust/blob/main/crates/emmylua_code_analysis/src/config/mod.rs
    -- https://github.com/EmmyLuaLs/emmylua-analyzer-rust/tree/main/crates/emmylua_code_analysis/src/config/configs
    emmylua = {
      hint = {
        enumParamHint = true,
      },
    },
  },
}
