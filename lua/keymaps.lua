local map = require('commons').utils.map

-- Disable arrow keys --
for _, mode in pairs { 'n', 'i', 'v', 'x' } do
  map(mode, '<up>', '<Nop>')
  map(mode, '<down>', '<Nop>')
  map(mode, '<left>', '<Nop>')
  map(mode, '<right>', '<Nop>')
end

-- Indentation --
-- <Esc> = <C-[> so mapping <C-[> malfunctions <Esc>
-- <C-i> = <S-Tab> so mapping <S-Tab> malfunctions <C-i> (which is for jumping to the next buffer)
-- map('n', '<C-[>', '<<_')
-- map('n', '<C-]>', '>>_')
-- map('v', '<C-[>', '<gv')
-- map('v', '<C-]>', '>gv')
map('n', '<', '<<_')
map('n', '>', '>>_')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move text up and down --
map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")
