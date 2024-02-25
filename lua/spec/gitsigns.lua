local gitsigns = {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 0,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Gitsigns: jump to next hunk' })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Gitsigns: jump to previous hunk' })

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Gitsigns: stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Gitsigns: reset hunk' })
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Gitsigns: stage hunk' })
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Gitsigns: reset hunk' })
      map(
        'n',
        '<leader>hS',
        gs.stage_buffer,
        { desc = 'Gitsigns: stage buffer' }
      )
      map(
        'n',
        '<leader>hu',
        gs.undo_stage_hunk,
        { desc = 'Gitsigns: undo stage hunk' }
      )
      map(
        'n',
        '<leader>hR',
        gs.reset_buffer,
        { desc = 'Gitsigns: reset buffer' }
      )
      map(
        'n',
        '<leader>hp',
        gs.preview_hunk,
        { desc = 'Gitsigns: preview hunk' }
      )
      map('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'Gitsigns: blame line' })
      map(
        'n',
        '<leader>tb',
        gs.toggle_current_line_blame,
        { desc = 'Gitsigns: toggle current line blame' }
      )
      map(
        'n',
        '<leader>hd',
        gs.diffthis,
        { desc = 'Gitsigns: diff against the index' }
      )
      map('n', '<leader>hD', function()
        gs.diffthis '~'
      end, { desc = 'Gitsigns: diff against the last commit' })
      map(
        'n',
        '<leader>td',
        gs.toggle_deleted,
        { desc = 'Gitsigns: toggle deleted' }
      )

      -- Text object
      map(
        { 'o', 'x' },
        'ih',
        ':<C-U>Gitsigns select_hunk<CR>',
        { desc = 'Gitsigns: select hunk' }
      )
    end,
  },
}

return gitsigns
