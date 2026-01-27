------@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = {
      highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = { "latex", "markdown" },
      },
    },

    config = function(_, opts)
      -- Disable tarballs for Tree-sitter (prefer git)
      require("nvim-treesitter.install").prefer_git = true

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
