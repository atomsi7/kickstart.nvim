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
      { '<leader>od', '<Cmd>Oil<CR>', desc = 'oil parent [D]irectory' },
    },
  },
  {
    'ahmedkhalf/project.nvim',
    event = 'VeryLazy',
    config = function()
      require('project_nvim').setup {
        manual_mode = true,
      }
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
    keys = {
      { '<leader>to', '<Cmd>OverseerToggle<CR>', desc = '[T]oggle [O]verseer' },
      { '<leader>or', '<Cmd>OverseerRun<CR>', desc = 'Overseer [R]un' },
    },
    config = function()
      require('overseer').setup {
        task_list = {
          max_height = { 30, 0.25 },
          heigth = 12,
          bindings = {
            ['?'] = 'ShowHelp',
            ['g?'] = 'ShowHelp',
            ['<CR>'] = 'RunAction',
            ['<C-e>'] = 'Edit',
            ['o'] = 'Open',
            ['<C-v>'] = 'OpenVsplit',
            ['<C-s>'] = 'OpenSplit',
            ['<C-f>'] = 'OpenFloat',
            ['<C-q>'] = 'OpenQuickFix',
            ['p'] = 'TogglePreview',
            ['K'] = 'IncreaseDetail',
            ['J'] = 'DecreaseDetail',
            ['L'] = 'IncreaseAllDetail',
            ['H'] = 'DecreaseAllDetail',
            ['['] = 'DecreaseWidth',
            [']'] = 'IncreaseWidth',
            ['{'] = 'PrevTask',
            ['}'] = 'NextTask',
            ['<C-u>'] = 'ScrollOutputUp',
            ['<C-d>'] = 'ScrollOutputDown',
            ['q'] = 'Close',
          },
        },
      }
    end,
  },
}
