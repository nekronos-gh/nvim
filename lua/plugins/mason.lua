---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "bash-language-server",
        "shfmt",
        "json-lsp",
        "jq",
        "marksman",
        "markdownlint",
        "taplo",
        "prettier",
        "yamlfmt",
      },
    },
  },
}
