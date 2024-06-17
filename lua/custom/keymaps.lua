local map = vim.keymap.set
local wk = require 'which-key'
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>x', '<cmd>bd<cr>', { desc = 'Close Buffer' })

map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Disable Ctrl-C in Normal and Visual Modes
map({ 'v', 'n' }, '<C-c>', '"+y')

-- Disable Ctrl-V in Insert, Normal, and Visual Modes
map('i', '<C-v>', '<Esc>"+pa')
map({ 'n', 'v' }, '<C-v>', '"+p')

map({ 'n', 'i', 'v' }, 'gA', 'ggVG', { desc = 'Select All' })
map({ 'n', 'i', 'v' }, '<C-z>', 'u')
map({ 'i', 'n', 'v' }, '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit All' })
wk.register {
  ['<C-i>'] = 'jump Next',
  ['<C-o>'] = 'jump Previous',
}
