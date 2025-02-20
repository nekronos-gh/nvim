return {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
        "ray-x/guihua.lua",
    },
    config = function()
        require("go").setup()
        -- Go setup enables diganostics again :(
        local diagnostic = vim.diagnostic
        diagnostic.config({
          virtual_text = false, 		-- Disable LSP diagnostics
        })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'}
}
