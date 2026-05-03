local options = {
  wildoptions = {
    'fuzzy',                                -- enable fuzzy matching in command-line mode
    'pum',                                  -- show completion menu while in command-line mode
  },
  pumheight = 10,                           -- maximum popup menu items
  ignorecase = true,                        -- ignore case in search patterns
  smartcase = true,                         -- case sensitive only when there is at least one uppercase letter in search patterns
  mouse = 'a',                              -- allow the mouse usage
  showcmd = false,                          -- hide (partial) command in the last line of the screen (for performance)
  showmode = false,                         -- hide things like -- INSERT --
  splitbelow = true,                        -- force all horizontal splits to go below current window
  splitright = true,                        -- force all vertical splits to go to the right of current window
  swapfile = false,                         -- don't create a swapfile
  undofile = true,                          -- enable persistent undo
  expandtab = true,                         -- convert tabs to spaces
  shiftround = true,                        -- round indent to multiple of `shiftwidth`
  shiftwidth = 2,                           -- number of spaces inserted for each indentation
  tabstop = 2,                              -- number of spaces for a tab
  cursorline = true,                        -- highlight the current line
  number = true,                            -- show line numbers
  relativenumber = true,                    -- show relative line numbers
  laststatus = 3,                           -- only the last window will always have a status line
  signcolumn = 'yes',                       -- always show the sign column, otherwise it would shift the text each time
  linebreak = true,                         -- wrap long lines at a character in `breakat` rather than at the last character that fits on the screen
  scrolloff = 8,                            -- minimum number of screen lines to keep above and below the cursor
  colorcolumn = '80',                       -- ruler
  spell = true,                             -- enable spell checking
  spelllang = 'en_us',                      -- languages used for spell checking
  synmaxcol = 500,                          -- limit max column for syntax highlighting to mitigate high loading time on big file
  winborder = 'rounded',                    -- border for floating windows
  pumborder = 'rounded',                    -- border for popup menus
  foldlevelstart = 99,                      -- don't fold everything on the first fold command (e.g. za, zc, etc.)
}

-- Problems with built-in completion:
-- - No highlight out of the box for the completion menu and the preview menu (preview menu show things like documentation), unlike the signature help (https://github.com/neovim/neovim/issues/29849).
-- - Enable `autocomplete` set `noselect` in `completeopt` unless `preinsert` is set in `completeopt`.
-- - `preinsert` in `completeopt` does not work with `fuzzy` (also needs to enable `infercase`).
-- - Sometimes completion menu shows up when not desired, pressing enter occasionally accept the completion item although we want to insert a newline.
-- - Control-space to trigger completion seems to not work as expected.
-- - When using Snacks picker with `autocomplete` enabled, completion kicks in and puts a halt to the picker functionality, until an item is selected the picker would function -> have to disable `autocomplete` when filetype is `snacks_picker_input`.
vim.g.use_builtin_completion = false
if vim.g.use_builtin_completion then
  options = vim.tbl_extend('force', options, {
    autocomplete = true,                      -- useful in buffers without a lsp client attached, show completion menu as you type, `:h complete` for the source list
    completeopt = {
      'fuzzy',                             -- enable fuzzy matching
      'menuone',                           -- show completion menu even when there is only one match
      'noinsert',                          -- no item is inserted until first selection
      'popup',                             -- show completion preview on selection
    },
  })
else
  options = vim.tbl_extend('force', options, {
    completeopt = {                           -- the chosen completion plugin would handle the completion preview and other things
      'fuzzy',                                -- although the chosen completion plugin has fuzzy matching support on its own, enable this to use with `omnicompletion`
      'menuone',                              -- show completion menu even when there is only one match
      'noinsert',                             -- no item is inserted until first selection
    },
  })
end

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.fillchars = { eob = ' ' }           -- show empty lines at the end of a buffer instead of the default `~`
vim.opt.whichwrap:append 'h,l'              -- keys allowed to move to the previous/next line when the beginning/end of line is reached

-- Mitigate high loading time on big file
-- Tests with value 0 show that these do not take effect, so choose value 1
vim.g.matchparen_timeout = 1                -- https://github.com/neovim/neovim/blob/master/runtime/plugin/matchparen.vim#L17
vim.g.matchparen_insert_timeout = 1         -- https://github.com/neovim/neovim/blob/master/runtime/plugin/matchparen.vim#L20

vim.g.mapleader = ' '                       -- map leader to space
