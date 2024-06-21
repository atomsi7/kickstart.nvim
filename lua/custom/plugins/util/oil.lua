return {
  {
    "stevearc/oil.nvim",
    lazy = true,
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
    keys = {
      { "<leader>od", "<Cmd>Oil<CR>", desc = "oil parent [D]irectory" },
    },
  },
}
