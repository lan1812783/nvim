local ensure_installed = {
  'html',
  'css',
  'javascript',
  'tsx',
  'cmake',
  'make',
  'cpp',
  'go',
  'java',
  'python',
  'bash',
  'yaml',
  'sql',
  'json',
  'lua',
}

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      require('nvim-treesitter').install(ensure_installed)
      require('nvim-treesitter').update()
    end
  end,
})

vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if
      ok
      and stats
      and stats.size > require('commons').constants.big_file_size
    then
      return
    end

    -- https://github.com/nvim-treesitter/nvim-treesitter/discussions/7894#discussioncomment-13287653
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype) --[[@as string]]
    if vim.treesitter.language.add(lang) then
      vim.wo[0][0].foldmethod = 'expr'
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
    end
  end,
})
