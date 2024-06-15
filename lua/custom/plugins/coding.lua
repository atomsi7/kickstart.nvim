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
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
        open_mapping = [[<M-i>]],
        shell = vim.o.shell,
        direction = 'float',
        auto_scroll = true,
      }
    end,
    keys = {
      { '<M-i>', '<cmd>ToggleTerm<CR>', { desc = 'ToggleTerm' } },
    },
  },
  {
    'linux-cultist/venv-selector.nvim',
    enabled = false,
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = true,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup {
        settings = {
          options = {},
          search = {
            anaconda_envs = {
              command = '$FD python.exe$ $CONDA_PREFIX/envs --max-depth 2 --type f --full-path --color never -E /proc -I -a -L',
              type = 'anaconda',
            },
            anaconda_base = {
              command = '$FD python.exe $CONDA_PREFIX --max-depth 1 --type f --full-path --color never -E /proc -I -a -L',
              type = 'anaconda',
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>v', '<cmd>VenvSelect<cr>', desc = '[V]envSelect' },
    },
    cmd = {
      'VenvSelect',
    },
  },
}
