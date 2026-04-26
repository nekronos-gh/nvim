return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
      })
    end,
  },

  -- Mason tools
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clangd",
        "clang-format",
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
          },
        },
      },
    },
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.c = { "clang-format" }
      opts.formatters_by_ft.cpp = { "clang-format" }
    end,
  },

  -- Linter
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"

      lint.linters_by_ft.c = { "clangtidy" }
      lint.linters_by_ft.cpp = { "clangtidy" }

      local lint_augroup = vim.api.nvim_create_augroup("nvim-lint-cpp", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
