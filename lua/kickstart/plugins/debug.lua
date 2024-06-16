-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  cmd = {
    'DapLoadLaunchJSON',
  },
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        -- Required dependency for nvim-dap-ui
        'nvim-neotest/nvim-nio',
      },
    },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<C-F5>', dap.run_to_cursor, desc = 'Debug: Run to Cursor' },
      { '<F11>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F10>', dap.step_over, desc = 'Debug: Step Over' },
      { '<S-F11>', dap.step_out, desc = 'Debug: Step Out' },
      { '<F9>', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      { '<S-F5>', dap.terminate, desc = 'Debug: Terminate' },
      { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<S-F9>',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug:Set Condition Breakpoint',
      },
      {
        '<leader>du',
        function()
          dapui.toggle {}
        end,
        desc = 'Dap UI',
      },
      { mode = { 'n', 'v' }, '<F3>', dapui.eval, desc = 'Eval' },
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
        'debugpy',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      controls = {
        icons = {
          disconnect = '  ',
          pause = '  ',
          play = '  ',
          run_last = '  ',
          step_back = '  ',
          step_into = '  ',
          step_out = '  ',
          step_over = '  ',
          terminate = '  ',
        },
      },
      layouts = {
        {
          elements = { {
            id = 'repl',
            size = 0.35,
          }, {
            id = 'console',
            size = 0.65,
          } },
          position = 'bottom',
          size = 15,
        },
        {
          elements = {
            {
              id = 'scopes',
              size = 0.8,
            },
            {
              id = 'stacks',
              size = 0.3,
            },
            {
              id = 'watches',
              size = 0.05,
            },
            {
              id = 'breakpoints',
              size = 0.1,
            },
          },
          position = 'left',
          size = 35,
        },
      },
    }

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
    require('dap-python').setup 'python'
  end,
}
