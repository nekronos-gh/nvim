-- Buffer management
vim.api.nvim_set_keymap('n', '<C-B>', '<cmd>NvimTreeToggle<cr>', {noremap=true}) -- Toggle NvimTree
vim.api.nvim_set_keymap('n', '<leader>x', '<cmd>bp<bar>sp<bar>bn<bar>bd<cr>', {noremap=true}) -- Delete buffer and avoid closing window

-- FZF usage
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>') -- File search
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua live_grep<cr>') -- Grep search
vim.keymap.set('v', '<leader>fv', '<cmd>FzfLua grep_visual<cr>') -- Grep search highlighted content under visual
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>') -- Grep search

-- LSP Diagnostics
vim.keymap.set('n', '<leader>j', function()
  vim.diagnostic.goto_next({ float = { source = true } })
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>k', function()
  vim.diagnostic.goto_prev({ float = { source = true } })
end, { noremap = true, silent = true })

-- Window navigation
vim.api.nvim_set_keymap('t', '<C-w>h', '<C-\\><C-n><C-w>h', {noremap=true, silent=true}) -- Use movement when on terminal
vim.api.nvim_set_keymap('t', '<C-w>j', '<C-\\><C-n><C-w>j', {noremap=true, silent=true})
vim.api.nvim_set_keymap('t', '<C-w>k', '<C-\\><C-n><C-w>k', {noremap=true, silent=true})
vim.api.nvim_set_keymap('t', '<C-w>l', '<C-\\><C-n><C-w>l', {noremap=true, silent=true})

-- Quick escape from terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap=true, silent=true})

-- Terminal management
local betterTerm = require('betterTerm')
for i = 0, 9 do
    vim.keymap.set({"n", "t"}, "<leader>t" .. i, function() betterTerm.open(i) end, { desc = "Open terminal"})
end

-- Resize windows using Alt + arrow keys
vim.api.nvim_set_keymap('n', '<M-k>', '<cmd>resize +5<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<M-j>', '<cmd>resize -5<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<M-h>', '<cmd>vertical resize -5<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', '<M-l>', '<cmd>vertical resize +5<CR>', {noremap=true})

vim.api.nvim_create_user_command('Wqa', function()
  vim.cmd('wa')
  vim.cmd('qa')
end, { desc = 'Write all writable buffers and quit, ignoring terminals' })
vim.api.nvim_set_keymap('n', '<leader>wq', '<cmd>Wqa<cr>', { noremap = true, silent = true })

vim.keymap.set({'n', 'v', 'i'}, '<leader>wqa', '<cmd>wa<cr><cmd>qa<cr>')


-- Set clipboard sharing with terminal emulator
-- Unnecesary in newer version of nvim
vim.keymap.set('n', '<leader>c', '<Plug>OSCYankOperator')
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', '<Plug>OSCYankVisual')

function copyFilePath()
    local path = vim.fn.expand('%:p')
    vim.cmd("OSCYank " .. path)
end

vim.keymap.set('n', '<leader>g', copyFilePath)




