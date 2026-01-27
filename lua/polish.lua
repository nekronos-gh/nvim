vim.o.exrc = true -- Enable reading .nvim.lua
vim.o.secure = true -- Restrict dangerous commands in local configs

-- Create a new autocommand group to prevent duplicate autocommands
local latex_augroup = vim.api.nvim_create_augroup("LatexClean", { clear = true })

-- Run latexmk -C on VimLeave
vim.api.nvim_create_autocmd("VimLeave", {
  group = latex_augroup,
  callback = function()
    vim.fn.jobstart("latexmk -c", { detach = true })
    vim.fn.jobstart("rm -f *.synctex.gz", { detach = true })
  end,
})

-- Set automatic read on file change
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "checktime",
})

-- Share clipboard wherever (guarded so Docker/headless won't fail)
local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
if ok then
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
end
