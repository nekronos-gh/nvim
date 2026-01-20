vim.o.exrc = true -- Enable reading .nvim.lua
vim.o.secure = true -- Restrict dangerous commands in local configs

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
    vim.fn.jobstart("latexmk -c", {
      type = "terminal",
      detach = true,
    })
    vim.fn.jobstart("rm -f *.synctex.gz", {
      type = "terminal",
      detach = true,
    })
  end,
})

-- Set automaitc read on file change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "checktime",
})

-- Share clipboard wherever
local osc52 = require "vim.ui.clipboard.osc52"
vim.g.clipboard = {
  name = "osc52 (copy only)",
  copy = {
    ["+"] = osc52.copy "+",
    ["*"] = osc52.copy "*",
  },
  paste = {
    -- Don't query terminal clipboard (prevents timeouts)
    ["+"] = function() return 0 end,
    ["*"] = function() return 0 end,
  },
}

-- Disable tarballs for Tree sitter
require("nvim-treesitter.install").prefer_git = true
