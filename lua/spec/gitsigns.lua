local gitsigns = {
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      delay = 0,
    },
    on_attach = function(bufnr)
      local gs = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gs.nav_hunk 'next'
        end
      end, { desc = 'Gitsigns: jump to next hunk' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gs.nav_hunk 'prev'
        end
      end, { desc = 'Gitsigns: jump to previous hunk' })

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
