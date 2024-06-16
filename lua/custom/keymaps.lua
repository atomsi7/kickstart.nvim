local map = vim.keymap.set
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
nmap('n', '<C-c>', '"+y', { noremap = true, silent = true })
nmap('v', '<C-c>', '"+y', { noremap = true, silent = true })

-- Disable Ctrl-V in Insert, Normal, and Visual Modes
nmap('i', '<C-v>', '<Esc>"+pa', { noremap = true, silent = true })
nmap('v', '<C-v>', '"+p', { noremap = true, silent = true })
nmap('n', '<C-v>', '"+p', { noremap = true, silent = true })

nmap('n', 'gA', 'ggVG', { noremap = true, silent = true, desc = 'Select All' })
nmap('n', '<C-z>', 'u', { noremap = true, silent = true })
wk.register {
  ['<C-i>'] = 'jump Next',
  ['<C-o>'] = 'jump Previous',
}
