return {
  -- Tree-sitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "rust" })
    end,
  },

  -- Language server
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      if not vim.g.nix_managed_tools then vim.list_extend(opts.ensure_installed, { "rust-analyzer" }) end
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "rust_analyzer" },
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
            },
          },
        },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = function(_, opts) opts.formatters_by_ft.rust = { "rustfmt" } end,
  },
}
