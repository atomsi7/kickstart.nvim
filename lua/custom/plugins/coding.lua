return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = true,
    cmd = {
      "ToggleTerm",
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          else
            return 20
          end
        end,
        open_mapping = [[<c-\>]],
        shell = vim.o.shell,
        direction = "tab",
        auto_scroll = true,
      })
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        display_name = "lazygit",
        direction = "float",
        float_opts = {
          border = "double",
        },
        hidden = true,
        -- function to run on opening the terminal
        on_open = function(term)
          -- vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<M-g>", "<cmd>close<cr>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function()
          vim.cmd("startinsert!")
        end,
      })
      function _Lazygit_toggle()
        lazygit:toggle()
      end

      -- Initialize variables to store terminals
      local terminals = {
        horizontal = { instance = nil, keymap = "<M-h>", },
        vertical = { instance = nil, keymap = "<M-v>", },
        float = { instance = nil, keymap = "<M-i>" },
        tab = { instance = nil, keymap = "<M-t>" }
      }

      -- Function to create and toggle a new terminal based on direction
      function _Toggle_default_term(direction)
        local function create_new_term(_direction)
          return Terminal:new({
            display_name = _direction,
            direction = _direction,
            hidden = true,
            on_open = function(term)
              vim.api.nvim_buf_set_keymap(term.bufnr, "t", terminals[_direction].keymap, "<cmd>close<cr>",
                { noremap = true, silent = true })
            end,
          })
        end
        local term = terminals[direction].instance

        if term then
          -- If the terminal exists, toggle it
          term:toggle()
        else
          -- If the terminal doesn't exist, create it
          term = create_new_term(direction)

          -- Store the created terminal in the terminals table
          terminals[direction].instance = term

          -- Toggle the newly created terminal
          term:toggle()
        end
      end

      function _Create_new_term(direction)
        Terminal:new({ direction = direction, hidden = false }):toggle()
      end
    end,
    keys = {
      { "<M-i>",       "<cmd>lua _Toggle_default_term('float')<CR>",      desc = "ToggleTerm float" },
      { "<M-g>",       "<cmd>lua _Lazygit_toggle()<CR>",                  desc = "toggle lazygit term" },
      { "<leader>ttv", "<cmd>lua _Create_new_term('vertical')<CR>",       desc = "Create vertical term" },
      { "<leader>tth", "<cmd>lua _Create_new_term('horizontal')<CR>",     desc = "Create horizontal term" },
      { "<M-v>",       "<cmd>lua _Toggle_default_term('vertical')<CR>",   desc = "Toggle vertical term" },
      { "<M-h>",       "<cmd>lua _Toggle_default_term('horizontal')<CR>", desc = "Toggle horizontal term" },
      { "<M-t>",       "<cmd>lua _Toggle_default_term('tab')<CR>",        desc = "Toggle tab term" },
      { "<C-S-\\>",    "<cmd>ToggleTermToggleAll<CR>",                    desc = "Toggle All term" },
      { "<C-\\>",      "which_key_ignore" }
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    enabled = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = true,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
      require("venv-selector").setup({
        settings = {
          options = {},
          search = {
            anaconda_envs = {
              command =
              "$FD python.exe$ $CONDA_PREFIX/envs --max-depth 2 --type f --full-path --color never -E /proc -I -a -L",
              type = "anaconda",
            },
            anaconda_base = {
              command = "$FD python.exe $CONDA_PREFIX --max-depth 1 --type f --full-path --color never -E /proc -I -a -L",
              type = "anaconda",
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>v", "<cmd>VenvSelect<cr>", desc = "[V]envSelect" },
    },
    cmd = {
      "VenvSelect",
    },
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      { "<leader>dx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>dX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>ds", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Symbols (Trouble)" },
      {
        "<leader>dl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>dq", "<cmd>Trouble qflist toggle<cr>",  desc = "Quickfix List (Trouble)" },
      {
        "gR",
        function()
          require("trouble").open("lsp_references")
        end,
        desc = "LSP References (Trouble)",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  {
    "folke/persistence.nvim",
    enabled = false,
    event = "VimEnter",
    opts = {
      options = vim.opt_global.sessionoptions:get(),
      -- Enable to autoload session on startup, unless:
      -- * neovim was started with files as arguments
      -- * stdin has been provided
      -- * git commit/rebase session
      autoload = true,
    },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
}
