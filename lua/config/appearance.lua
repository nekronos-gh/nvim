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

-- Notifications
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },

    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },

                    { find = "fewer lines" },
                },
            },
            view = "mini",
        },
    },
})
