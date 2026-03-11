return {
  "max397574/better-escape.nvim",
  opts = {
    timeout = vim.o.timeoutlen,
    default_mappings = false, -- setting this to false removes all the default mappings
    mappings = {
      -- i for insert
      i = {
        j = {
          j = "<Esc>",
        },
      },
      c = {
        j = {
          j = "<C-c>",
        },
      },
    },
  },
}
