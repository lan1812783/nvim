-- :h :DiffOrig
vim.api.nvim_create_user_command('DiffOrig', function()
  vim.cmd(
    'vert new | set buftype=nofile | set filetype='
      .. vim.bo.filetype
      .. ' | read ++edit # | 0d_ | diffthis | wincmd p | diffthis'
  )
end, {})
