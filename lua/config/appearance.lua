local command = vim.cmd
local option = vim.opt
command('set undofile');        -- Undofiles for after session undoing
command('set number')           -- Absolute numbering
command('set nowrap')           -- No text wrapping

command('set colorcolumn=120')  -- Max character column
command('set cursorline')       -- Set color under current line
command('hi CursorLine term=bold cterm=bold guibg=Grey10')

command('set tabstop=4')        -- Tabs are visualized as 4 spaces
command('set shiftwidth=4')     -- Inserts 4 spaces
command('set expandtab')        -- Tabs insert spaces

-- Set indicator for trailing spaces and tabs
option.list = true
command('set listchars=tab:>>,trail:_,extends:>,precedes:<,nbsp:~')

-- Change colorscheme
command('colorscheme gruvbox')
command('colorscheme gruvbox-material')
command('set background=dark')
require('lualine').setup{
    options = {
        theme = 'gruvbox_dark'
    },
}

require('nvim-treesitter.configs').setup{
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'go' },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
