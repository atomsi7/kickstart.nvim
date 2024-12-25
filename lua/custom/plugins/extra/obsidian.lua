return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "preservim/vim-markdown",
    },
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "/c/second-brain/**.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/c/second-brain/**.md",
    -- },
    cmd = {
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianFollowLink",
      "ObsidianBacklinks",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTemplate",
      "ObsidianSearch",
      "ObsidianLink",
      "ObsidianLinkNew",
    },

    opts = {
      workspaces = {
        {
          name = "personal",
          path = "D:\\Onebox\\Note\\personal",
        },
        {
          name = "work",
          path = "D:\\Onebox\\Note\\work",
        },
      },
      daily_notes = {
        folder = "dailies",
      },
    },

    -- mappings = {
    --   ["gf"] = require("obsidian.mapping").gf_passthrough(),
    -- },

    -- config = function(_, opts)
    --   require("obsidian").setup(opts)
    --   vim.keymap.set("n", "gd", function()
    --     if require("obsidian").util.cursor_on_markdown_link() then
    --       return "<cmd>ObsidianFollowLink<CR>"
    --     else
    --       return "gd"
    --     end
    --   end, { noremap = false, expr = true })
    -- end,
  },
}
