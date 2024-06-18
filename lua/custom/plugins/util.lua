return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = {
      {
        '<LocalLeader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Add Location',
      },
      {
        '<C-n>',
        function()
          require('harpoon'):list():next()
        end,
        desc = 'Next Location',
      },
      {
        '<C-p>',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'Previous Location',
      },
      {
        '<LocalLeader>d',
        function()
          require('harpoon'):list():remove()
        end,
        desc = 'Remove Location',
      },
      {
        '<LocalLeader>1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Harpoon to File 1',
      },
      {
        '<LocalLeader>2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Harpoon to File 2',
      },
      {
        '<LocalLeader>3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Harpoon to File 3',
      },
      {
        '<LocalLeader>4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Harpoon to File 4',
      },
      {
        '<LocalLeader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'Harpoon to File 5',
      },

      {
        '<LocalLeader>l',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'List locations',
      },
    },
  },
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
