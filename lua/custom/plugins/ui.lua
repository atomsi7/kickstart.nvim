return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diagnostics_dict)
          if diagnostics_dict.error then
            local sym = ""
            return diagnostics_dict.error .. sym
          else
            return ""
          end
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      return opts
    end,
    config = function()
      local fn = vim.fn

      local function spell()
        if vim.o.spell then
          return string.format("[SPELL]")
        end

        return ""
      end

      --- show indicator for Chinese IME
      local function ime_state()
        if vim.g.is_mac then
          -- ref: https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/xkblayout.vim#L11
          local layout = fn.libcall(vim.g.XkbSwitchLib, "Xkb_Switch_getXkbLayout", "")

          -- We can use `xkbswitch -g` on the command line to get current mode.
          -- mode for macOS builtin pinyin IME: com.apple.inputmethod.SCIM.ITABC
          -- mode for Rime: im.rime.inputmethod.Squirrel.Rime
          local res = fn.match(layout, [[\v(Squirrel\.Rime|SCIM.ITABC)]])
          if res ~= -1 then
            return "[CN]"
          end
        end

        return ""
      end

      local function trailing_space()
        if not vim.o.modifiable then
          return ""
        end

        local line_num = nil

        for i = 1, fn.line("$") do
          local linetext = fn.getline(i)
          -- To prevent invalid escape error, we wrap the regex string with `[[]]`.
          local idx = fn.match(linetext, [[\v\s+$]])

          if idx ~= -1 then
            line_num = i
            break
          end
        end

        local msg = ""
        if line_num ~= nil then
          msg = string.format("[%d]trailing", line_num)
        end

        return msg
      end

      local function mixed_indent()
        if not vim.o.modifiable then
          return ""
        end

        local space_pat = [[\v^ +]]
        local tab_pat = [[\v^\t+]]
        local space_indent = fn.search(space_pat, "nwc")
        local tab_indent = fn.search(tab_pat, "nwc")
        local mixed = (space_indent > 0 and tab_indent > 0)
        local mixed_same_line
        if not mixed then
          mixed_same_line = fn.search([[\v^(\t+ | +\t)]], "nwc")
          mixed = mixed_same_line > 0
        end
        if not mixed then
          return ""
        end
        if mixed_same_line ~= nil and mixed_same_line > 0 then
          return "MI:" .. mixed_same_line
        end
        local space_indent_cnt = fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
        local tab_indent_cnt = fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
        if space_indent_cnt > tab_indent_cnt then
          return "MI:" .. tab_indent
        else
          return "MI:" .. space_indent
        end
      end

      local diff = function()
        local git_status = vim.b.gitsigns_status_dict
        if git_status == nil then
          return
        end

        local modify_num = git_status.changed
        local remove_num = git_status.removed
        local add_num = git_status.added

        local info = { added = add_num, modified = modify_num, removed = remove_num }
        -- vim.print(info)
        return info
      end

      local virtual_env = function()
        -- only show virtual env for Python
        if vim.bo.filetype ~= "python" then
          return ""
        end

        local conda_env = os.getenv("CONDA_DEFAULT_ENV")
        local venv_path = os.getenv("VIRTUAL_ENV")

        if venv_path == nil then
          if conda_env == nil then
            return ""
          else
            return string.format("  %s (conda)", conda_env)
          end
        else
          local venv_name = vim.fn.fnamemodify(venv_path, ":t")
          return string.format("  %s (venv)", venv_name)
        end
      end

      local overseer = require("overseer")
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          section_separators = "",
          component_separators = "",
          disabled_filetypes = {
            "dapui_watches",
            "dapui_breakpoints",
            "dapui_scopes",
            "dapui_console",
            "dapui_stacks",
            "dap-repl",
            "OverseerList",
            "trouble",
          },
          always_divide_middle = true,
        },
        --stylua: ignore
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            { "diff", source = diff },
            { virtual_env, color = { fg = "black", bg = "#F1CA81" } },
          },
          lualine_c = {
            "filename",
            { ime_state, color = { fg = "black", bg = "#f46868" } },
            { spell, color = { fg = "black", bg = "#a7c080" } },
            { "diagnostics", sources = { "nvim_diagnostic" }, symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          },
          lualine_x = {
            {
              "overseer",
              label = "", -- Prefix for task counts
              colored = true, -- Color the task icons and counts
              symbols = {
                [overseer.STATUS.FAILURE] = " ",
                [overseer.STATUS.CANCELED] = " ",
                [overseer.STATUS.SUCCESS] = " ",
                [overseer.STATUS.RUNNING] = " ",
              },
              unique = false, -- Unique-ify non-running task count by name
              name = nil, -- List of task names to search for
              name_not = false, -- When true, invert the name search
              status = nil, -- List of task statuses to display
              status_not = false, -- When true, invert the status search
            },
            "encoding",
            { "fileformat", symbols = { unix = "unix", dos = "win", mac = "mac", } },
            "filetype",
          },
          lualine_y = {
            "location",
          },
          lualine_z = {
            { trailing_space, color = "WarningMsg" },
            { mixed_indent, color = "WarningMsg" },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "neo-tree" },
      })
    end,
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = {
      -- add any options here
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
    },
    --stylua: ignore
    keys = {
      { "<leader>s<S-n>", "", desc = "[N]oice" },
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>s<S-n>l", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>s<S-n>h", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>s<S-n>a", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>s<S-n>d", function() require("noice").cmd("dismiss") end, desc = "[D]ismiss All" },
      { "<leader>s<S-n>t", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = { "i", "n", "s" } },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
    config = function()
      require("noice").setup({
        views = {
          cmdline_popup = {
            position = {
              row = 13,
              col = "50%",
            },
            size = {
              width = 60,
              height = 1,
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 16,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    --stylua: ignore
    keys = {
      { "<leader>tn", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss All [N]otifications" },
      { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "[N]otify Telescope" },
    },
    opts = {
      stages = "static",
      timeout = 1500,
      max_height = function()
        return math.floor(vim.o.lines * 0.6)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.6)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      vim.notify = require("notify")
      require("telescope").load_extension("notify")
    end,
  },
}
