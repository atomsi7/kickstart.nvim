return {
  "olimorris/persisted.nvim",
  event = "VimEnter",
  opts = function()
    if LazyVim.has("telescope.nvim") then
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("persisted")
      end)
    end
    local group = vim.api.nvim_create_augroup("PersistedHooks", {})
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedSavePre",
      group = group,
      callback = function()
        -- Ensure the minimap plugin is not written into the session
        vim.cmd("Neotree close")
      end,
    })
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedTelescopeLoadPre",
      group = group,
      callback = function()
        -- Close and delete all open buffers
        vim.cmd("%bd")
      end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "PersistedLoadPost",
      group = group,
      callback = function()
        vim.notify("Loaded session in " .. vim.fn.getcwd())
      end,
    })
    return {
      autoload = true,
      on_autoload_no_session = function()
        vim.notify("No existing session to load.")
      end,
      ignored_dirs = {
        { "~", exact = true },
      },
    }
  end,
  keys = {
    {
      "<leader>sS",
      "<cmd>Telescope persisted<cr>",
      { desc = "[S]ession" },
    },
  },
}
