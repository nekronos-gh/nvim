-- Mason LSP, DAP, linters 
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

-- Remove diagnostic text
vim.diagnostic.config({
  virtual_text = {
    format = function(d) return "" end
  },
  signs = false
})

-- Open diagnostics on hover
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    callback = function()
        vim.diagnostic.open_float(nil, {focusable = false})
    end,
})

