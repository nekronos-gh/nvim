-- Mason LSP, DAP, linters 
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

-- Disable LSP diagnostics for lsp_lines to work
vim.diagnostic.config({
  virtual_text = false,
})

-- For diagnostics
require('lsp_lines').setup()

