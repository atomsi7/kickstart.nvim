local default_proxy = vim.g.default_proxy
local function mask_password(url)
  return string.gsub(url, '(https?://.-:)(.-)(@)', '%1********%3')
end

local function set_proxy()
  vim.env.http_proxy = default_proxy
  vim.env.https_proxy = default_proxy
  vim.env.all_proxy = default_proxy
  vim.notify('Proxy has been set to: ' .. mask_password(default_proxy), vim.log.levels.INFO)
end

-- Function to unset proxy
local function unset_proxy()
  vim.env.http_proxy = nil
  vim.env.https_proxy = nil
  vim.env.all_proxy = nil
  vim.notify('Proxy has been unset.', vim.log.levels.INFO)
end

set_proxy()

-- Create commands to set and unset proxy
vim.api.nvim_create_user_command('SetProxy', set_proxy, {})
vim.api.nvim_create_user_command('UnsetProxy', unset_proxy, {})
