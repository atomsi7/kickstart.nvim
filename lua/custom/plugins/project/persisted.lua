return {
  'olimorris/persisted.nvim',
  lazy = false, -- make sure the plugin is always loaded at startup
  config = function()
    require('persisted').setup {
      autoload = true,
      on_autoload_no_session = function()
        vim.notify 'No existing session to load.'
      end,
      ignored_dirs = {
        { '~', exact = true },
      },
    }

    local group = vim.api.nvim_create_augroup('PersistedHooks', {})
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = group,
      callback = function()
        -- Ensure the minimap plugin is not written into the session
        vim.cmd 'Neotree close'
      end,
    })
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedTelescopeLoadPre',
      group = group,
      callback = function()
        -- Close and delete all open buffers
        vim.cmd '%bd'
      end,
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedLoadPost',
      group = group,
      callback = function()
        vim.notify('Loaded session in ' .. vim.fn.getcwd())
      end,
    })
  end,
  keys = {
    {
      '<leader>sS',
      '<cmd>Telescope persisted<cr>',
      { desc = '[S]ession' },
    },
  },
}
