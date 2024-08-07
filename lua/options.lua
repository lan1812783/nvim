local options = {
  backup = false,                          -- creates a backup file
  clipboard = 'unnamedplus',               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = 'utf-8',                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = 'a',                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeout = true,
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  laststatus = 3,                          -- only the last window will always have a status line
  showcmd = false,                         -- hide (partial) command in the last line of the screen (for performance)
  ruler = false,                           -- hide the line and column number of the cursor position
  numberwidth = 4,                         -- minimal number of columns to use for the line number {default 4}
  signcolumn = 'yes',                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  linebreak = true,                        -- wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  -- sidescrolloff = 8,                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
  guifont = 'monospace:h17',               -- the font used in graphical neovim applications
  -- guicursor = 'a:block',                   -- all modes use the same block cursor (default: n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20)
  colorcolumn = '80',                      -- ruler
  spell = true,                            -- spell checking
  spelllang = 'en_us',                     -- comma-separated list of word list names.  When the 'spell' option is on spellchecking will be done for these languages
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars.eob = ' '                    -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append 'c'                   -- hide all the completion messages, e.g. '-- XXX completion (YYY)', 'match 1 of 2', 'The only match', 'Pattern not found'
vim.opt.whichwrap:append '<,>,[,],h,l'         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
-- vim.opt.iskeyword:append '-'                   -- treats words with `-` as single words
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- This is a sequence of letters which describes how automatic formatting is to be done

-- Mitigate high loading time on big file
-- Tests with value 0 show that these do not take affect, so choose value 1
vim.g.matchparen_timeout = 1        -- https://github.com/neovim/neovim/blob/master/runtime/plugin/matchparen.vim#L15
vim.g.matchparen_insert_timeout = 1 -- https://github.com/neovim/neovim/blob/master/runtime/plugin/matchparen.vim#L18

-- Capture the diff mode flag globally because tests show that
-- when nvim is open in diff mode (e.g. via git difftool, nvim -d, etc),
-- a ftplugin script is called as many times as the number of buffers opened for diff viewing,
-- and it seems like vim.opt.diff returns true only on the first time a ftplugin script is called,
-- subsequent calls result in false to be returned, which makes this api not appropriate
-- to be used in ftplugin scripts when nvim is in diff mode
vim.g.diffmode = vim.opt.diff:get()
