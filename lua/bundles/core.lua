return {
  -- Tree-sitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "json",
        "jsonc",
        "bash",
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
      })
    end,
    config = function(_, opts)
      -- Disable tarballs for Tree-sitter (prefer git)
      require("nvim-treesitter.install").prefer_git = true

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- Binary installer for LSP, Linters, formatters, ...
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "json-lsp",
        "marksman",
        "markdownlint",
        "taplo",
        "prettier",
        "yaml-language-server",
        "yamlfmt",
      },
    },
  },
  -- Formatter plugin
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        jsonc = { "prettier" },
        markdown = { "prettier" },
        yaml = { "yamlfmt" },
        toml = { "taplo" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
  -- Linter plugin
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
