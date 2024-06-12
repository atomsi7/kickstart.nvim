local map = vim.keymap.set
map('n', '<S-Tab>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
map('n', '<Tab>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })
