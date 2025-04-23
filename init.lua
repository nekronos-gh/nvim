vim.g.mapleader = ','

-- Init file for nvim configuration
require('plugins.lazy')	-- Plugins

-- Execute configuration files
local config_dir = './lua/config'
for file in io.popen('ls ' .. config_dir):lines() do
    if file:match("%.lua$") then
        dofile(config_dir .. '/' .. file)
    end
end




