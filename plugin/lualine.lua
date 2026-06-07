vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
}

local winbar = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {},
  lualine_x = {
    {
      'filename',
      path = 1, -- 0: Just the filename
      -- 1: Relative path
      -- 2: Absolute path
      -- 3: Absolute path, with tilde as the home directory
      -- 4: Filename and parent dir, with tilde as the home directory
    },
  },
  lualine_y = {},
  lualine_z = {},
}
require('lualine').setup {
  options = {
    disabled_filetypes = { -- Filetypes to disable lualine for.
      winbar = { 'NvimTree', 'dap-repl', 'dap-view', 'qf' }, -- only ignores the ft for winbar.
    },
  },
  extensions = {
    'mason',
    'nvim-tree',
    'quickfix',
  },
  winbar = winbar,
  inactive_winbar = winbar,
}
