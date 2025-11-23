vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.hl.on_yank { timeout = 150 }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'help', 'checkhealth' },
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})

-- https://google.github.io/styleguide/javaguide.html#s4.4-column-limit
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'java' },
  callback = function()
    vim.opt_local.colorcolumn = '100'
  end,
})

-- https://cbea.ms/git-commit/#limit-50
-- https://cbea.ms/git-commit/#wrap-72
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  callback = function()
    vim.opt_local.colorcolumn = '50,72'
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.spell = false
  end,
})
