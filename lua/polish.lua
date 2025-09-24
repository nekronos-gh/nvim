-- Disable latex for Vimtex
require("nvim-treesitter.configs").setup {
  ensure_installed = { "markdown" },
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = { "latex", "markdown" },
  },
}

-- Create a new autocommand group to prevent duplicate autocommands
local latex_augroup = vim.api.nvim_create_augroup("LatexClean", { clear = true })

-- Run latexmk -C on VimLeave
vim.api.nvim_create_autocmd("VimLeave", {
  group = latex_augroup,
  callback = function()
    vim.fn.jobstart("latexmk -C", {
      type = "terminal",
      detach = true,
    })
  end,
})
