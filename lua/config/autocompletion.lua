local cmp = require('cmp')

-- Shared confirmation options
local confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
}

-- AI assisted completion
require("codeium").setup({
    api = {
        host = "codingbuddy.onprem.gic.ericsson.se",
        path = "/_route/api_server",
        portal_url = "codingbuddy.onprem.gic.ericsson.se"
    },
    enterprise_mode = true
})

-- Default completion for buffer editing
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm(confirm_opts),
        ['<Tab>'] = cmp.mapping.confirm(confirm_opts),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'codeium' },
        { name = 'path' },
    }
})

