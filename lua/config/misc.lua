require('betterTerm').setup({
    opts = {
        position = 'bot',
        size = 15,
    },
    prefix = 'T'
})

-- Update time for diagnostics
vim.cmd('set updatetime=1000')
-- Automatically read changes in file
vim.cmd('set autoread')
--
vim.cmd('autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None')

