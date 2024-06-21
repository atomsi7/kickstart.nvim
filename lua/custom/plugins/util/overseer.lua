return {
  {
    "stevearc/overseer.nvim",
    lazy = true,
    opts = {},
    cmd = {
      "OverseerRun",
      "OverseerToggle",
    },
    keys = {
      { "<leader>to", "<Cmd>OverseerToggle<CR>", desc = "[T]oggle [O]verseer" },
      { "<leader>or", "<Cmd>OverseerRun<CR>", desc = "Overseer [R]un" },
    },
    config = function()
      require("overseer").setup({
        task_list = {
          max_height = { 30, 0.25 },
          heigth = 12,
          bindings = {
            ["?"] = "ShowHelp",
            ["g?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["<C-e>"] = "Edit",
            ["o"] = "Open",
            ["<C-v>"] = "OpenVsplit",
            ["<C-s>"] = "OpenSplit",
            ["<C-f>"] = "OpenFloat",
            ["<C-q>"] = "OpenQuickFix",
            ["p"] = "TogglePreview",
            ["K"] = "IncreaseDetail",
            ["J"] = "DecreaseDetail",
            ["L"] = "IncreaseAllDetail",
            ["H"] = "DecreaseAllDetail",
            ["["] = "DecreaseWidth",
            ["]"] = "IncreaseWidth",
            ["{"] = "PrevTask",
            ["}"] = "NextTask",
            ["<C-u>"] = "ScrollOutputUp",
            ["<C-d>"] = "ScrollOutputDown",
            ["q"] = "Close",
          },
        },
      })
    end,
  },
  -- FIXME: this integradtion will loaded casued the error
  -- sections to be nil.
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local overseer = require("overseer")
  --     table.insert(opts.sections.lualine_x, 1, {
  --       "overseer",
  --       label = "", -- Prefix for task counts
  --       colored = true, -- Color the task icons and counts
  --       symbols = {
  --         [overseer.STATUS.FAILURE] = " ",
  --         [overseer.STATUS.CANCELED] = " ",
  --         [overseer.STATUS.SUCCESS] = " ",
  --         [overseer.STATUS.RUNNING] = " ",
  --       },
  --       unique = false, -- Unique-ify non-running task count by name
  --       name = nil, -- List of task names to search for
  --       name_not = false, -- When true, invert the name search
  --       status = nil, -- List of task statuses to display
  --       status_not = false, -- When true, invert the status search
  --     })
  --   end,
  -- },
}
