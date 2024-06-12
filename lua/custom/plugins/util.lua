return {
  {
    'stevearc/oil.nvim',
    lazy = true,
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = false,
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
        },
        view_options = {
          show_hidden = true,
        },
      }
    end,
    keys = {
      { '<leader>o', '<Cmd>Oil<CR>', desc = '[O]il(parent directory)' },
    },
  },
  {
    'ahmedkhalf/project.nvim',
    opts = {},
    event = 'VeryLazy',
    config = function(_, opts)
      require('project_nvim').setup(opts)
      -- Directly load the telescope extension without LazyVim
      require('telescope').load_extension 'projects'
    end,
    keys = {
      { '<leader>sp', '<Cmd>Telescope projects<CR>', desc = '[S]earch [P]rojects' },
    },
  },
  {
    'stevearc/overseer.nvim',
    lazy = true,
    opts = {},
    cmd = {
      'OverseerRun',
      'OverseerToggle',
    },
    config = function()
      require('overseer').setup()
    end,
  },
}
