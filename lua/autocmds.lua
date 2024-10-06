vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 150 }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'help' },
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.spell = false
  end,
})
