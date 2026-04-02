return {
  -- Treesitter (disable LaTeX highlighting -> handled by vimtex)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "latex",
        "bibtex",
      })

      opts.highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex", "markdown" },
      }
    end,
  },

  -- Mason tools
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "texlab",
        "latexindent",
      })
    end,
  },

  -- LSP (texlab WITHOUT build -> vimtex handles it)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                onSave = false, -- IMPORTANT: avoid conflict with vimtex
              },
              chktex = {
                onOpenAndSave = true,
                onEdit = false,
              },
              diagnosticsDelay = 300,
              latexFormatter = "latexindent",
              latexindent = {
                modifyLineBreaks = false,
              },
              bibtexFormatter = "texlab",
              formatterLineLength = 120,
            },
          },
        },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.tex = { "latexindent" }
      opts.formatters_by_ft.bib = { "texlab" }
    end,
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft.tex = { "chktex" }
    end,
  },

  -- VimTeX (core)
  {
    "lervag/vimtex",
    lazy = false,

    init = function()
      -- Compiler
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      -- UI / UX
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_fold_enabled = 1

      vim.g.vimtex_toc_config = {
        name = "TOC",
        layers = { "content", "todo", "include" },
        split_width = 35,
        show_help = 1,
        show_numbers = 1,
      }

      -- Conceal (nice symbols)
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        styles = 1,
      }
    end,

    config = function()
      -- ✅ SAFE AUTO CLEANUP ON EXIT
      local latex_augroup = vim.api.nvim_create_augroup("LatexClean", { clear = true })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = latex_augroup,
        callback = function()
          -- Only run if vimtex is active
          if vim.fn.exists "*vimtex#clean" == 1 then vim.cmd "silent! VimtexClean" end
        end,
      })
    end,

    keys = {
      { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Compile" },
      { "<leader>lv", "<cmd>VimtexView<cr>", desc = "View PDF" },
      { "<leader>lt", "<cmd>VimtexTocToggle<cr>", desc = "TOC" },
      { "<leader>le", "<cmd>VimtexErrors<cr>", desc = "Errors" },
      { "<leader>lc", "<cmd>VimtexClean<cr>", desc = "Clean" },
      { "<leader>lC", "<cmd>VimtexClean!<cr>", desc = "Clean all" },
      { "<leader>lk", "<cmd>VimtexStop<cr>", desc = "Stop compiler" },
      { "<leader>li", "<cmd>VimtexInfo<cr>", desc = "Info" },
    },
  },
}
