local tokyonight = {
  'folke/tokyonight.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

local colorscheme = 'tokyonight-night'

function tokyonight.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  if not status_ok then
    vim.notify('Colorscheme ' .. colorscheme .. ' not found --> using the default one!')
    return
  end
end

return tokyonight
