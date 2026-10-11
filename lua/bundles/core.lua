return {
  -- Tree-sitter parser
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    main = "nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "json",
        "bash",
        "markdown",
        "markdown_inline",
        "yaml",
        "toml",
      })
    end,
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)
      vim.treesitter.language.register("json", { "jsonc" })

      local parser_languages = {}
      local filetypes = {}
      for _, lang in ipairs(opts.ensure_installed) do
        if lang ~= "markdown_inline" and lang ~= "latex" then
          parser_languages[lang] = true
          for _, filetype in ipairs(vim.treesitter.language.get_filetypes(lang)) do
            filetypes[filetype] = true
          end
        end
      end
      local filetype_patterns = vim.tbl_keys(filetypes)
      table.sort(filetype_patterns)

      local treesitter_group = vim.api.nvim_create_augroup("nvim-treesitter-highlighting", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = treesitter_group,
        pattern = filetype_patterns,
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and parser_languages[lang] and vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
            if lang == "markdown" then vim.bo[args.buf].syntax = "ON" end
          end
        end,
      })
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
      ensure_installed = vim.g.nix_managed_tools and {} or {
        "lua-language-server",
        "stylua",
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "json-lsp",
        "marksman",
        "taplo",
        "prettier",
        "yaml-language-server",
        "yamlfmt",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      if vim.g.nix_managed_tools then opts.ensure_installed = {} end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if vim.g.nix_managed_tools then opts.ensure_installed = {} end
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "lua_ls", "bashls", "jsonls", "marksman", "taplo", "yamlls" },
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
