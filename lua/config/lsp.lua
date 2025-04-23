-- Mason LSP, DAP, linters 
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

-- For diagnostics
require('lsp_lines').setup()

