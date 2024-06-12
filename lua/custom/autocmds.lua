local defualt_proxy = 'http://localhost:7890'
local function set_proxy()
  vim.env.http_proxy = defualt_proxy
  vim.env.https_proxy = defualt_proxy
  vim.env.all_proxy = defualt_proxy
end

-- Function to unset proxy
local function unset_proxy()
  vim.env.http_proxy = nil
  vim.env.https_proxy = nil
  vim.env.all_proxy = nil
end

set_proxy()

-- Create commands to set and unset proxy
vim.api.nvim_create_user_command('SetProxy', set_proxy, {})
vim.api.nvim_create_user_command('UnsetProxy', unset_proxy, {})
