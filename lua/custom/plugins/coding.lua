return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    lazy = true,
    cmd = {
      'ToggleTerm',
    },
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        shell = vim.o.shell,
        direction = 'horizontal',
        auto_scroll = true,
      }
    end,
    keys = {
      { '<C-\\>', '<cmd>ToggleTerm<CR>', { desc = 'ToggleTerm' } },
    },
  },
}
